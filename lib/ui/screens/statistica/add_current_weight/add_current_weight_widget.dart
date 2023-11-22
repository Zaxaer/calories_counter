import 'package:calories_calculator/domine/blocs/statistic_bloc/add_current_bloc.dart';
import 'package:calories_calculator/ui/screens/statistica/add_current_weight/add_current_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCurrentWeighnWidget extends StatelessWidget {
  const AddCurrentWeighnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddCurrentWeightBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            AppImages.back,
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          ),
          splashRadius: 20,
          onPressed: () => bloc.add(NavigatorPopCurrentWeight()),
        ),
      ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ButtonAddWeight(
                      image: AppImages.minus,
                      math: () => bloc.add(DiffCurrentWeightEvent())),
                  const SizedBox(width: 8),
                  _InputWeightWidget(),
                  const SizedBox(width: 8),
                  _ButtonAddWeight(
                    image: AppImages.plus,
                    math: () => bloc.add(SumCurrentWeightEvent()),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            const _SaveButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class _SaveButtonWidget extends StatelessWidget {
  const _SaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    final bloc = context.read<AddCurrentWeightBloc>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => bloc.add(NavigatorPopCurrentWeight()),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 54),
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(color),
        ),
        child: const Text(
          'SAVE',
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

class _ButtonAddWeight extends StatelessWidget {
  final String image;
  final void Function() math;
  const _ButtonAddWeight({
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
          onPressed: () => math(),
          icon: Image.asset(image)),
    );
  }
}

class _InputWeightWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController(text: '1');
  _InputWeightWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddCurrentWeightBloc>();
    controller.text = bloc.state.weightText;
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
    return SizedBox(
      width: 79,
      height: 40,
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        onChanged: (value) => bloc.add(InputCurrentWeightEvent(weight: value)),
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
