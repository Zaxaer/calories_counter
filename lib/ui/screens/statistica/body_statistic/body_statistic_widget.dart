import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/ui/navigation/main_navigation.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/statistic/statistic_model.dart';

// ignore: must_be_immutable
class BodyStatisticWidget extends StatelessWidget {
  final int index;
  var date = '';
  BodyStatisticWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticModel>();
    final _dateFormat = DateFormat('EEEE., d MMMM', 'ru');
    date = _dateFormat.format(DateTime.now());
    model.awesomeText(index);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      model.weight[index].isPrefectWeight == false
                          ? model.weight[index].weight.toString() + ' kg'
                          : model.weight[index].weight.toString() +
                              model.wantedWeight,
                      style: const TextStyle(
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        height: 1.485,
                        fontFamily: AppFonts.mPlusRounded,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      model.weight.last == model.weight[index] ||
                              model.isAddButton == true
                          ? model.awesome
                          : '',
                      style: const TextStyle(
                        color: Color(0xFFD75755),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        height: 1.485,
                        fontFamily: AppFonts.ubuntu,
                      ),
                    )
                  ],
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.375,
                    fontFamily: AppFonts.ubuntu,
                  ),
                ),
                model.weight.last != model.weight[index] &&
                        model.isAddButton == false
                    ? const SizedBox(height: 48)
                    : const SizedBox.shrink(),
                model.isAddButton == true || model.weight.length == 1
                    ? const _AddCurrentWeight()
                    : const SizedBox.shrink(),
              ],
            ),
            const Expanded(child: SizedBox()),
            IconButton(
                iconSize: 40,
                splashRadius: 40,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => model.deleteGroup(index),
                icon: const Icon(Icons.delete,
                    color: Color(0xFFC4C4C4), size: 24)),
          ],
        ),
        SizedBox(
          width: 15,
          height: 15,
          child: CustomPaint(
            painter: _ProgressCircle(),
          ),
        ),
        model.weight.length > 1 && model.weight.last != model.weight[index]
            ? const Positioned(
                top: 14,
                left: 5,
                child: SizedBox(
                  width: 5,
                  height: 250,
                  child: ColoredBox(
                    color: Color(0xFF5DACE9),
                  ),
                ),
              )
            : const SizedBox.shrink()
      ]),
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
  const _AddCurrentWeight({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model =
        context.watch<StatisticModel>().weight.last.isPrefectWeight == true;
    return Padding(
      padding: EdgeInsets.only(top: 32, bottom: model ? 32 : 0),
      child: SizedBox(
        width: 170,
        height: 40,
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFF6C042)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(const Size(142, 40)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () =>
              Navigator.of(context).pushNamed(Screen.addingCurrentWeight),
          child: const Text(
            'Add current weight',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.485,
              fontFamily: AppFonts.mPlusRounded,
            ),
          ),
        ),
      ),
    );
  }
}
