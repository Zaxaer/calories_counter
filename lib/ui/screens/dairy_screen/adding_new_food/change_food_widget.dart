import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/resources/resources.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/adding_new_food/change_food_model.dart';

class ChangeFoodWidget extends StatefulWidget {
  const ChangeFoodWidget({Key? key}) : super(key: key);

  @override
  State<ChangeFoodWidget> createState() => _ChangeFoodWidgetState();
}

class _ChangeFoodWidgetState extends State<ChangeFoodWidget> {
  ChangeFoodWidgetModel? _model;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = ChangeFoodWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _model, child: const ChangeBodyWidget());
  }
}

class ChangeBodyWidget extends StatelessWidget {
  const ChangeBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: const SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: _AddingFoodParametrsWidget(),
        ),
      ),
    );
  }
}

class _AddingFoodParametrsWidget extends StatelessWidget {
  const _AddingFoodParametrsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Change food',
          style: TextStyle(
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            fontSize: 24,
            height: 1.16,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mPlusRounded,
          ),
        ),
        const SizedBox(height: 24),
        const _NessesaryFieldsWidget(),
        const SizedBox(height: 20),
        const _AllOtherStaff(),
        const SizedBox(height: 51),
        const _SaveButton(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangeFoodWidgetModel>();
    final color = Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => model.addFoodData(context),
        child: const Text(
          'SAVE CHANGE',
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

class _AllOtherStaff extends StatelessWidget {
  const _AllOtherStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangeFoodWidgetModel>();
    return Container(
        padding: const EdgeInsets.all(20),
        height: 255,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFEBDBAF),
              spreadRadius: 5,
              blurRadius: 30,
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'All other staff',
            style: TextStyle(
              fontFamily: AppFonts.mPlusRounded,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              height: 1.46,
            ),
          ),
          const SizedBox(height: 10),
          Column(children: [
            _AllOtherStaffTextFieldWidget(
              lableText: 'Protein per serving',
              suffixText: 'g',
              onChanged: (text) => model.protein = text,
              inputType: TextInputType.number,
              text: model.protein,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            _AllOtherStaffTextFieldWidget(
              lableText: 'Sugar per serving',
              suffixText: 'g',
              onChanged: (text) => model.sugar = text,
              inputType: TextInputType.number,
              text: model.sugar,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            _AllOtherStaffTextFieldWidget(
              lableText: 'Fat per serving',
              suffixText: 'g',
              onChanged: (text) => model.fat = text,
              inputType: TextInputType.number,
              text: model.fat,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ])
        ]));
  }
}

class _NessesaryFieldsWidget extends StatelessWidget {
  const _NessesaryFieldsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangeFoodWidgetModel>();
    return Container(
      padding: const EdgeInsets.all(20),
      height: 191,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEBDBAF),
            spreadRadius: 5,
            blurRadius: 30,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nessesary fields',
            style: TextStyle(
              fontFamily: AppFonts.mPlusRounded,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              height: 1.46,
            ),
          ),
          Column(children: [
            _AllOtherStaffTextFieldWidget(
              lableText: 'Food name',
              suffixText: '',
              onChanged: (text) => model.foodName = text,
              inputType: TextInputType.text,
              text: model.foodName,
              inputFormatters: const [],
            ),
            _AllOtherStaffTextFieldWidget(
              lableText: 'Calories per serving',
              suffixText: 'cal',
              onChanged: (text) => model.calories = text,
              inputType: TextInputType.number,
              text: model.calories,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ]),
          model.errorMassege == true
              ? const _ErrorTextNessesary()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _ErrorTextNessesary extends StatelessWidget {
  const _ErrorTextNessesary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        'Common, it is nessesary',
        style: TextStyle(
          color: Color(0xFFD75755),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.375,
          fontFamily: AppFonts.ubuntu,
        ),
      ),
    );
  }
}

class AllOtherStaff {
  String lableText;
  String suffixText;
  AllOtherStaff({
    required this.lableText,
    required this.suffixText,
  });
}

// ignore: must_be_immutable
class _AllOtherStaffTextFieldWidget extends StatefulWidget {
  final String text;
  final String lableText;
  final String suffixText;
  final TextInputType inputType;
  void Function(String) onChanged;
  List<TextInputFormatter> inputFormatters;
  _AllOtherStaffTextFieldWidget({
    Key? key,
    required this.text,
    required this.lableText,
    required this.suffixText,
    required this.inputType,
    required this.onChanged,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  State<_AllOtherStaffTextFieldWidget> createState() =>
      _AllOtherStaffTextFieldWidgetState();
}

class _AllOtherStaffTextFieldWidgetState
    extends State<_AllOtherStaffTextFieldWidget> {
  final TextEditingController controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    controller.text = widget.text;
    return TextField(
      inputFormatters: widget.inputFormatters,
      controller: controller,
      keyboardType: widget.inputType,
      onChanged: widget.onChanged,
      style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.375),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9E9E9E)),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD75755)),
        ),
        isDense: true,
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF333333),
        ),
        suffixIcon: Text(
          widget.suffixText,
          style: const TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 16,
              fontFamily: AppFonts.ubuntu,
              fontWeight: FontWeight.w400,
              height: 1.375),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 22,
          maxWidth: 24,
        ),
        label: Text(
          widget.lableText,
          style: const TextStyle(
            fontFamily: AppFonts.ubuntu,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.375,
          ),
        ),
      ),
    );
  }
}
