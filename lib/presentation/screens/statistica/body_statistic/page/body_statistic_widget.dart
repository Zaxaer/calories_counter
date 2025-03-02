import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:calories_calculator/presentation/screens/statistica/statistic/bloc/statistic_bloc.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/presentation/screens/statistica/statistic/bloc/statistic_bloc_event.dart';

class BodyStatisticWidget extends StatelessWidget {
  final int index;
  const BodyStatisticWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StatisticBloc>();
    final dateFormat = DateFormat('EEEE., d MMMM', 'ru');
    final date = dateFormat.format(DateTime.now());
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 30),
            _InfoLogicWidget(bloc: bloc, index: index, date: date),
          ],
        ),
        Positioned(right: 0, child: _IconWidget(bloc: bloc, index: index)),
        SizedBox(
          width: 15,
          height: 15,
          child: CustomPaint(painter: _ProgressCircle()),
        ),
        bloc.state.weight.length > 1 &&
                bloc.state.weight.last != bloc.state.weight[index]
            ? const Positioned(
              top: 14,
              left: 5,
              child: SizedBox(
                width: 5,
                height: 500,
                child: ColoredBox(color: Color(0xFF5DACE9)),
              ),
            )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _InfoLogicWidget extends StatelessWidget {
  const _InfoLogicWidget({
    required this.bloc,
    required this.index,
    required this.date,
  });

  final StatisticBloc bloc;
  final int index;
  final String date;
  @override
  Widget build(BuildContext context) {
    var awesome = '';
    var isAddButton = false;
    if (index == 0) {
      if (bloc.state.weight.last.isPrefectWeight == true &&
          bloc.state.weight.reversed.elementAt(1) == bloc.state.weight[index]) {
        isAddButton = true;
      }
    }
    if (index >= 1) {
      if (bloc.state.weight.last.isPrefectWeight == false &&
          bloc.state.weight.last == bloc.state.weight[index]) {
        if (bloc.state.weight.last.weight <
            bloc.state.weight.reversed.elementAt(1).weight) {
          awesome = 'Awesome';
        }
        isAddButton = true;
      } else if (bloc.state.weight.last.isPrefectWeight == true &&
          bloc.state.weight.reversed.elementAt(1) == bloc.state.weight[index]) {
        if (bloc.state.weight.reversed.elementAt(1).weight <
            bloc.state.weight.reversed.elementAt(2).weight) {
          awesome = 'Awesome';
        }
        isAddButton = true;
      }
      if (bloc.state.weight.last.isPrefectWeight == true &&
          bloc.state.weight.last == bloc.state.weight[index]) {}
    }
    return _InfoCreateWidget(
      bloc: bloc,
      date: date,
      index: index,
      isAddButton: isAddButton,
      awesome: awesome,
    );
  }
}

class _InfoCreateWidget extends StatelessWidget {
  final bool isAddButton;
  final String awesome;
  final StatisticBloc bloc;
  final int index;
  final String date;
  const _InfoCreateWidget({
    required this.isAddButton,
    required this.awesome,
    required this.bloc,
    required this.index,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WeightValueWidget(
            bloc: bloc,
            index: index,
            isAddButton: isAddButton,
            awesome: awesome,
          ),
          _DataWidget(date: date),
          bloc.state.weight.last != bloc.state.weight[index] &&
                  isAddButton == false
              ? const SizedBox(height: 48)
              : const SizedBox.shrink(),
          isAddButton == true || bloc.state.weight.length == 1
              ? const _AddCurrentWeight()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget({required this.bloc, required this.index});

  final StatisticBloc bloc;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      splashRadius: 40,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () => bloc.add(DeleteWeightStatisticEvent(index: index)),
      icon: const Icon(Icons.delete, color: Color(0xFFC4C4C4), size: 24),
    );
  }
}

class _DataWidget extends StatelessWidget {
  const _DataWidget({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      style: const TextStyle(
        color: Color(0xFF4F4F4F),
        fontWeight: FontWeight.w400,
        fontSize: 18,
        height: 1.375,
        fontFamily: AppFonts.ubuntu,
      ),
    );
  }
}

class _WeightValueWidget extends StatelessWidget {
  final bool isAddButton;
  final String awesome;
  const _WeightValueWidget({
    required this.isAddButton,
    required this.awesome,
    required this.bloc,
    required this.index,
  });

  final StatisticBloc bloc;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            bloc.state.weight[index].isPrefectWeight == false
                ? '${bloc.state.weight[index].weight} kg'
                : bloc.state.weight[index].weight.toString() +
                    bloc.state.wantedWeight,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w800,
              fontSize: 18,
              height: 1.485,
              fontFamily: AppFonts.mPlusRounded,
            ),
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          bloc.state.weight.last == bloc.state.weight[index] ||
                  isAddButton == true
              ? awesome
              : '',
          style: const TextStyle(
            color: Color(0xFFD75755),
            fontWeight: FontWeight.w400,
            fontSize: 18,
            height: 1.485,
            fontFamily: AppFonts.ubuntu,
          ),
        ),
      ],
    );
  }
}

class _ProgressCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintCircle = Paint();
    paintCircle.color = const Color(0xFF3D80F6);
    canvas.drawCircle(Offset(size.width / 2, size.width / 2), 7.5, paintCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _AddCurrentWeight extends StatelessWidget {
  const _AddCurrentWeight();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StatisticBloc>();
    final bottom = bloc.state.weight.last.isPrefectWeight == true;
    return Padding(
      padding: EdgeInsets.only(top: 32, bottom: bottom ? 32 : 0),
      child: ElevatedButton(
        style: const ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 5)),
        ),
        onPressed: () => bloc.add(NavigatorAddCurrentWeightStatisticEvent()),
        child: const Text(
          'Add current weight',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.485,
            fontFamily: AppFonts.mPlusRounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
