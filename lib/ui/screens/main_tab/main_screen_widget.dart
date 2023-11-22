import 'package:calories_calculator/domine/blocs/main_screen_bloc/main_screen_bloc.dart';
import 'package:calories_calculator/domine/factory/screen_factory.dart';
import 'package:calories_calculator/ui/screens/main_tab/main_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenWidget extends StatelessWidget {
  final ScreenFactory screenFactory;
  const MainScreenWidget({Key? key, required this.screenFactory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTabIndex =
        context.select((MainScreenBloc value) => value.state.currentTabIndex);
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: currentTabIndex,
          children: [
            screenFactory.dairyScreenWidget(),
            screenFactory.statisticWidget(),
            screenFactory.profileWidget(),
          ],
        ),
        bottomNavigationBar: const _BottomBarWidget(),
      ),
    );
  }
}

class _BottomBarWidget extends StatelessWidget {
  const _BottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTabIndex =
        context.select((MainScreenBloc value) => value.state.currentTabIndex);
    final theme = Theme.of(context).bottomNavigationBarTheme;
    final buttons = const [
      _ButtonWidget(
        iconName: AppImages.union,
        textLable: 'ДНЕВНИК',
      ),
      _ButtonWidget(
        iconName: AppImages.scatictic,
        textLable: 'СТАТИСТИКА',
      ),
      _ButtonWidget(
        iconName: AppImages.profile,
        textLable: 'ПРОФИЛЬ',
      ),
    ]
        .asMap()
        .map((index, value) {
          return MapEntry(
              index, value.build(index, currentTabIndex, theme, context));
        })
        .values
        .toList();
    return SizedBox(
      height: 56,
      child: Row(
        children: buttons.map((button) => Expanded(child: button)).toList(),
      ),
    );
  }
}

class _ButtonWidget {
  final String iconName;
  final String textLable;
  static const _cornerRadius = 10.0;
  const _ButtonWidget({
    required this.iconName,
    required this.textLable,
  });

  ElevatedButton build(int index, int currentIndex,
      BottomNavigationBarThemeData theme, BuildContext context) {
    final bloc = context.select((MainScreenBloc bloc) => bloc);
    final colorButton =
        index == currentIndex ? const Color(0xFFFDF1DE) : theme.backgroundColor;
    final colorLable = index == currentIndex
        ? theme.selectedItemColor
        : theme.unselectedItemColor;
    final topLeft = index == currentIndex + 1 ? _cornerRadius : 0.0;
    final topRight = index == currentIndex - 1 ? _cornerRadius : 0.0;
    return ElevatedButton(
      style: ButtonStyle(
        animationDuration: Duration.zero,
        elevation: MaterialStateProperty.all(0.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
            ),
          ),
        ),
        shadowColor: MaterialStateProperty.all(const Color(0xFFFDF1DE)),
        backgroundColor: MaterialStateProperty.all(colorButton),
      ),
      onPressed: () => bloc.add(SelectScreen(index: index)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconName,
            width: 24,
            height: 24,
            color: colorLable,
          ),
          Text(
            textLable,
            style: TextStyle(
              fontFamily: AppFonts.mPlusRounded,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              height: 1.4,
              color: colorLable,
            ),
          ),
        ],
      ),
    );
  }
}
