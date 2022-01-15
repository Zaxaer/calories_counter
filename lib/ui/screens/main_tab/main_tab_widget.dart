import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/resources/resources.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/dairy_screen_model.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/dairy_screen_widget.dart';
import 'package:calorie_calculator_exemple/ui/screens/main_tab/main_tab_model.dart';
import 'package:calorie_calculator_exemple/ui/screens/profile/profile_widget.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/statistic/statistic_model.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/statistic/statistic_widget.dart';

class MainTabsScreenWidget extends StatelessWidget {
  const MainTabsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = context.watch<MainTabModel>().currentTabIndex;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        body: IndexedStack(
          index: index,
          children: [
            ChangeNotifierProvider(
              child: const DairyScreenWidget(),
              create: (_) => DairyScreenModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => StatisticModel(),
              child: const StatisticWidget(),
            ),
            const ProfileWidget(),
          ],
        ),
        bottomNavigationBar: const _BottomBar(),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        context.select((MainTabModel value) => value.currentTabIndex);
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
              index, value.build(index, currentIndex, theme, context));
        })
        .values
        .toList();
    return SizedBox(
        height: 56,
        child: Row(
            children:
                buttons.map((button) => Expanded(child: button)).toList()));
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
        onPressed: () => context.read<MainTabModel>().setCurrentTabIndex(index),
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
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.4,
                color: colorLable,
              ),
            ),
          ],
        ));
  }
}
