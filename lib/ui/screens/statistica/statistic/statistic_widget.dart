import 'package:calorie_calculator_exemple/ui/screens/statistica/statistic/statistic_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/ui/navigation/main_navigation.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/body_statistic/body_statistic_widget.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weight = context.watch<StatisticModel>().weight;
    return Scaffold(
      body: weight.isEmpty
          ? const _ButtonAddWeightWidget(
              text: 'Add you current weight',
              topPadding: 56,
              pushRoute: Screen.addingCurrentWeight,
            )
          : const _BodyStatistic(),
    );
  }
}

class _BodyStatistic extends StatelessWidget {
  const _BodyStatistic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticModel>().weight;
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            model.isNotEmpty
                ? const _StepWeightStatistic()
                : const SizedBox.shrink(),
            model.isNotEmpty && model.last.isPrefectWeight == false
                ? const _ButtonLearnPerfectWeight(
                    text: 'Learn you perfect weight',
                    topPadding: 20,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _ButtonLearnPerfectWeight extends StatelessWidget {
  final String text;
  final double topPadding;
  const _ButtonLearnPerfectWeight({
    Key? key,
    required this.text,
    required this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<StatisticModel>();
    return Padding(
      padding:
          EdgeInsets.only(top: topPadding, left: 16, right: 16, bottom: 16),
      child: Stack(children: [
        Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFEBDBAF),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 15),
                  ),
                ]),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontWeight: FontWeight.w800,
                fontSize: 20,
                height: 1.485,
                fontFamily: AppFonts.mPlusRounded,
              ),
            )),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => model.addPerfectWeight(context),
            ),
          ),
        ),
      ]),
    );
  }
}

class _ButtonAddWeightWidget extends StatelessWidget {
  final String text;
  final String pushRoute;
  final double topPadding;
  const _ButtonAddWeightWidget({
    Key? key,
    required this.text,
    required this.pushRoute,
    required this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: topPadding, left: 16, right: 16, bottom: 16),
      child: Stack(children: [
        Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFEBDBAF),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 15),
                  ),
                ]),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontWeight: FontWeight.w800,
                fontSize: 20,
                height: 1.485,
                fontFamily: AppFonts.mPlusRounded,
              ),
            )),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.of(context).pushNamed(pushRoute),
            ),
          ),
        )
      ]),
    );
  }
}

class _StepWeightStatistic extends StatefulWidget {
  const _StepWeightStatistic({
    Key? key,
  }) : super(key: key);

  @override
  State<_StepWeightStatistic> createState() => _StepWeightStatisticState();
}

class _StepWeightStatisticState extends State<_StepWeightStatistic> {
  @override
  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticModel>().weight;
    return Padding(
      padding: const EdgeInsets.only(top: 56, left: 16, right: 16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 161),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFEBDBAF),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 15),
              ),
            ]),
        child: Column(
            children: model
                .asMap()
                .map((index, value) {
                  return MapEntry(index, BodyStatisticWidget(index: index));
                })
                .values
                .toList()),
      ),
    );
  }
}
