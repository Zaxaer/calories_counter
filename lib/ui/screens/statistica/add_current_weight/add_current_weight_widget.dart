import 'package:calorie_calculator_exemple/ui/screens/statistica/statistic/statistic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/resources/resources.dart';

class AddCurrentWeighnWidget extends StatelessWidget {
  const AddCurrentWeighnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final math = context.read<StatisticModel>();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Image.asset(AppImages.back,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor),
                splashRadius: 20,
                onPressed: () => Navigator.of(context).pop())),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add current weight',
                style: TextStyle(
                  color: Color(0xFFD75755),
                  fontSize: 24,
                  height: 1.16,
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.mPlusRounded,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 80,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ButtonAddWeight(
                      image: AppImages.minus,
                      math: math.diff,
                    ),
                    const SizedBox(width: 8),
                    const _InputWeightWidget(),
                    const SizedBox(width: 8),
                    _ButtonAddWeight(
                      image: AppImages.plus,
                      math: math.sum,
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              const _SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    final model = context.read<StatisticModel>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => model.saveWeight(context),
        child: const Text(
          'SAVE',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mPlusRounded,
              fontSize: 18,
              height: 1.33),
        ),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 54),
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(color),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ButtonAddWeight extends StatelessWidget {
  final String image;
  void Function() math;
  _ButtonAddWeight({
    Key? key,
    required this.image,
    required this.math,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF2F2F2),
      ),
      child: IconButton(
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
          onPressed: math,
          icon: Image.asset(image)),
    );
  }
}

class _InputWeightWidget extends StatefulWidget {
  const _InputWeightWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_InputWeightWidget> createState() => _InputWeightWidgetState();
}

class _InputWeightWidgetState extends State<_InputWeightWidget> {
  final TextEditingController controller = TextEditingController(text: '1');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = context.watch<StatisticModel>();
    controller.text = model.weightInput;
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticModel>();
    return SizedBox(
      width: 79,
      height: 40,
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        onChanged: (value) => model.weightInput = value,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.mPlusRounded,
        ),
        decoration: const InputDecoration(
          suffixText: 'kg',
          suffixStyle: TextStyle(
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.mPlusRounded,
          ),
          contentPadding: EdgeInsets.only(bottom: 10),
        ),
      ),
    );
  }
}
