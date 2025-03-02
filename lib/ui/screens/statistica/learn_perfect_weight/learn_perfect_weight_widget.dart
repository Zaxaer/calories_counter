import 'package:calories_calculator/domine/blocs/statistic_bloc/learn_perfect_weight_bloc.dart';
import 'package:calories_calculator/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_event.dart';
import 'package:flutter/material.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnPerfectWeightWidget extends StatelessWidget {
  const LearnPerfectWeightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnPerfectWeightBloc>();
    return Scaffold(
      floatingActionButton: const _ResultButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            AppImages.back,
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          ),
          splashRadius: 20,
          onPressed: () => bloc.add(NavigatopPopLearnPerfectWeightEvent()),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 100, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}

class _MathMetodPerfectWeightWidget extends StatelessWidget {
  const _MathMetodPerfectWeightWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LearnPerfectWeightBloc>();
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
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TextFieldWidget(
                helpText: 'Ege',
                onChanged:
                    (text) => bloc.add(
                      InputAgeLearnPerfectWeightEvent(textInput: text),
                    ),
              ),
              const SizedBox(width: 40),
              const _GenderButtonSelectWidget(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TextFieldWidget(
                helpText: 'Growth',
                onChanged:
                    (text) => bloc.add(
                      InputGrowthLearnPerfectWeightEvent(textInput: text),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Your perfect weight is ${bloc.state.perfectWeight} kg',
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
                onPressed:
                    () => bloc.add(NavigatopInfoLearnPerfectWeightEvent()),
                icon: Image.asset(AppImages.question),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GenderButtonSelectWidget extends StatelessWidget {
  const _GenderButtonSelectWidget();
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LearnPerfectWeightBloc>();
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
        borderRadius: BorderRadius.circular(10),
        fillColor: const Color(0xFFFBE19B),
        borderColor: Colors.transparent,
        disabledBorderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        onPressed:
            (int index) => bloc.add(
              GenderSelectLearnPerfectWeightEvent(indexGender: index),
            ),
        isSelected: bloc.state.isSelected,
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
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final String helpText;
  final void Function(String) onChanged;
  const _TextFieldWidget({required this.helpText, required this.onChanged});

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

class _ResultButtonWidget extends StatelessWidget {
  const _ResultButtonWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnPerfectWeightBloc>();
    final color = Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () => bloc.add(ResultLearnPerfectWeightEvent()),
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 54)),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: WidgetStateProperty.all(color),
        ),
        child: const Text(
          'RESULT',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mPlusRounded,
            fontSize: 18,
            height: 1.33,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
