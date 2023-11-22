import 'package:calories_calculator/domine/blocs/statistic_bloc/statistic_bloc.dart';
import 'package:calories_calculator/ui/screens/statistica/statistic/statistic_bloc_event.dart';
import 'package:flutter/material.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/ui/screens/statistica/body_statistic/body_statistic_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<StatisticBloc>();
    return Scaffold(
      body: bloc.state.weight.isEmpty
          ? _ButtonWidget(
              text: 'Add you current weight',
              function: () =>
                  bloc.add(NavigatorAddCurrentWeightStatisticEvent()),
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
    final bloc = context.watch<StatisticBloc>();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          bloc.state.weight.isNotEmpty
              ? const _StepWeightStatistic()
              : const SizedBox.shrink(),
          bloc.state.weight.isNotEmpty &&
                  bloc.state.weight.last.isPrefectWeight == false
              ? _ButtonWidget(
                  text: 'Learn you perfect weight',
                  function: () => bloc.add(LearnPerfectWeightStatisticEvent()))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  final String text;
  final void Function() function;
  const _ButtonWidget({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
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
              ],
            ),
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
              onTap: () => function(),
            ),
          ),
        ),
      ],
    );
  }
}

class _StepWeightStatistic extends StatelessWidget {
  const _StepWeightStatistic({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<StatisticBloc>();
    return Container(
      margin: const EdgeInsets.only(top: 56, left: 16, right: 16),
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
        ],
      ),
      child: Column(
        children: bloc.state.weight
            .asMap()
            .map(
              (index, value) {
                return MapEntry(
                  index,
                  BodyStatisticWidget(index: index),
                );
              },
            )
            .values
            .toList(),
      ),
    );
  }
}
