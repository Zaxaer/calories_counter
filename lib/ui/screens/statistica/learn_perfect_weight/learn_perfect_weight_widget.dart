import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/resources/resources.dart';
import 'package:calorie_calculator_exemple/ui/navigation/main_navigation.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_model.dart';

class LearnPerfectWeightWidget extends StatelessWidget {
  const LearnPerfectWeightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<LearnPerfectWeightModel>();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
          floatingActionButton: const _ResultButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
              leading: IconButton(
                  icon: Image.asset(AppImages.back,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor),
                  splashRadius: 20,
                  onPressed: () =>
                      Navigator.pop(context, model.perfectWeight))),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 100, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Learn you perfect weight',
                    style: TextStyle(
                      color: Color(0xFFD75755),
                      fontSize: 24,
                      height: 1.16,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mPlusRounded,
                    ),
                  ),
                  SizedBox(height: 24),
                  _MathMetodPerfectWeightWidget(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )),
    );
  }
}

class _MathMetodPerfectWeightWidget extends StatelessWidget {
  const _MathMetodPerfectWeightWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LearnPerfectWeightModel>();
    return Container(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TextFieldWidget(
                  helpText: 'Ege', onChanged: (text) => model.ege = text),
              const SizedBox(width: 40),
              const _GenderButtonSelect(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TextFieldWidget(
                  helpText: 'Hight', onChanged: (text) => model.hight = text),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Your perfect weight is ${model.perfectWeight} kg',
                  style: const TextStyle(
                    color: Color(0xFFD75755),
                    fontSize: 18,
                    height: 1.13334,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.ubuntu,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(Screen.infoPerfectWeightWidget),
                icon: Image.asset(AppImages.question),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _GenderButtonSelect extends StatefulWidget {
  const _GenderButtonSelect({Key? key}) : super(key: key);

  @override
  State<_GenderButtonSelect> createState() => _GenderButtonSelectState();
}

class _GenderButtonSelectState extends State<_GenderButtonSelect> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<LearnPerfectWeightModel>();
    const style = TextStyle(
      color: Color(0xFF333333),
      fontSize: 16,
      height: 1.485,
      fontWeight: FontWeight.w500,
      fontFamily: AppFonts.mPlusRounded,
    );
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 44,
      child: ToggleButtons(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Male', style: style),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Female', style: style),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        fillColor: const Color(0xFFFBE19B),
        borderColor: Colors.transparent,
        disabledBorderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        onPressed: (int index) => model.genderSelect(index),
        isSelected: model.isSelected,
      ),
    );
  }
}

// ignore: must_be_immutable
class _TextFieldWidget extends StatelessWidget {
  final String helpText;
  void Function(String) onChanged;
  _TextFieldWidget({
    Key? key,
    required this.helpText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 68,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 12),
            label: Text(
              helpText,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.roboto,
                color: Color(0xFF999999),
              ),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.roboto,
          ),
        ),
      ),
    );
  }
}

class _ResultButton extends StatelessWidget {
  const _ResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<LearnPerfectWeightModel>();
    final color = Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () => model.youPerfectWeight(),
        child: const Text(
          'RESULT',
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
