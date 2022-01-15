import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/resources/resources.dart';
import 'package:calorie_calculator_exemple/ui/navigation/main_navigation.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/dairy_screen_model.dart';

class DairyScreenWidget extends StatelessWidget {
  const DairyScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = context.watch<DairyScreenModel>().stringFromDate();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          date.toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mPlusRounded,
            fontSize: 18,
            height: 1.596,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: const [
            _HeaderWidget(),
            _BodyWidget(),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DairyScreenModel>().caloriesOnDay;
    return SizedBox(
      height: 75,
      child: Container(
        height: 75,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFEBDBAF),
                offset: Offset(0.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 26, left: 20),
              child: Text(
                '$model cal so far',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  height: 1.485,
                  fontFamily: AppFonts.mPlusRounded,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            const _ButtonAddWidget(),
          ],
        ),
      ),
    );
  }
}

class _ButtonAddWidget extends StatelessWidget {
  const _ButtonAddWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStateProperty.all(const Color(0xFFF6C042)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(const Size(142, 40)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: () => Navigator.of(context).pushNamed(Screen.addFood),
        child: const Text(
          'Add Something',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.485,
            fontFamily: AppFonts.mPlusRounded,
          ),
        ),
      ),
    );
  }
}

class _BodyDairyWidget extends StatelessWidget {
  const _BodyDairyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DairyScreenModel>().foodInDay;
    return Column(
        children: model
            .asMap()
            .map((index, value) {
              return MapEntry(index, _FoodNameList(index: index));
            })
            .values
            .toList());
  }
}

class _FoodNameList extends StatelessWidget {
  final int index;
  const _FoodNameList({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DairyScreenModel>();
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => model.deleteGroup(index),
            backgroundColor: const Color(0xFFD75755),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Text(
                    model.foodInDay[index].foodName +
                        ', ${model.foodInDay[index].caloriesInDay.toString()}' +
                        ' pc',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      height: 1.333,
                      fontFamily: AppFonts.ubuntu,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    model.foodInDay[index].caloriesDay.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      height: 1.333,
                      fontFamily: AppFonts.ubuntu,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Image.asset(AppImages.more),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFC8C8C8)),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DairyScreenModel>().foodInDay;
    return Container(
      constraints:
          const BoxConstraints(minHeight: 360, minWidth: double.infinity),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: model.isEmpty
          ? const _BodyFoodEmptyWidget()
          : const _BodyDairyWidget(),
    );
  }
}

class _BodyFoodEmptyWidget extends StatelessWidget {
  const _BodyFoodEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 97),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            AppImages.arrow,
            color: const Color(0xFF5DACE9),
            width: 75,
            height: 66,
          ),
          const SizedBox(height: 10),
          const Text(
            'Add that you ate',
            style: TextStyle(
              fontFamily: AppFonts.mPlusRounded,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
