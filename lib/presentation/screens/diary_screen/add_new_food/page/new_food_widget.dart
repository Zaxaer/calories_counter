import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_bloc.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_event.dart';
import 'package:calories_calculator/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddNewFood extends NewFoodBloc {
  AddNewFood(
    super.initialState,
    super.context, {
    required super.hiveRepository,
  });
}

class AddNewFoodWidget extends StatelessWidget {
  const AddNewFoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(AppImages.back, color: const Color(0xFFD75755)),
          splashRadius: 20,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: _AddFoodParametrsWidget(),
      ),
    );
  }
}

class _AddFoodParametrsWidget extends StatelessWidget {
  const _AddFoodParametrsWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adding new food',
          style: TextStyle(
            color: Color(0xFFD75755),
            fontSize: 24,
            height: 1.16,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mPlusRounded,
          ),
        ),
        SizedBox(height: 24),
        _NessesaryFieldsWidget(),
        SizedBox(height: 20),
        _AllOtherStaffWidget(),
        SizedBox(height: 51),
        _SaveButtonWidget(),
        SizedBox(height: 20),
      ],
    );
  }
}

class _SaveButtonWidget extends StatelessWidget {
  const _SaveButtonWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewFoodBloc>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => bloc.add(AddNewFoodInListEvent()),
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 54)),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: WidgetStateProperty.all(const Color(0xFFD75755)),
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

class _AllOtherStaffWidget extends StatelessWidget {
  const _AllOtherStaffWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewFoodBloc>();
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minHeight: 255),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Color(0xFFEBDBAF), spreadRadius: 5, blurRadius: 30),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Column(
            children: [
              _AllOtherStaffTextFieldWidget(
                lableText: 'Protein per serving',
                suffixText: 'g',
                onChanged:
                    (text) => bloc.add(ProteinFoodInListEvent(protein: text)),
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              _AllOtherStaffTextFieldWidget(
                lableText: 'Sugar per serving',
                suffixText: 'g',
                onChanged:
                    (text) => bloc.add(SugarFoodInListEvent(sugar: text)),
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              _AllOtherStaffTextFieldWidget(
                lableText: 'Fat per serving',
                suffixText: 'g',
                onChanged: (text) => bloc.add(FatFoodInListEvent(fat: text)),
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NessesaryFieldsWidget extends StatelessWidget {
  const _NessesaryFieldsWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewFoodBloc>();
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minHeight: 191),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Color(0xFFEBDBAF), spreadRadius: 5, blurRadius: 30),
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
          Column(
            children: [
              _AllOtherStaffTextFieldWidget(
                lableText: 'Food name',
                suffixText: '',
                onChanged:
                    (text) => bloc.add(FoodNameInListEvent(foodName: text)),
                inputType: TextInputType.text,
                inputFormatters: const [],
              ),
              _AllOtherStaffTextFieldWidget(
                lableText: 'Calories per serving',
                suffixText: 'cal',
                onChanged:
                    (text) => bloc.add(CaloriesFoodInListEvent(calories: text)),
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
          bloc.state.errorMassege == true
              ? const _ErrorTextNessesaryWidget()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _ErrorTextNessesaryWidget extends StatelessWidget {
  const _ErrorTextNessesaryWidget();

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

class _AllOtherStaffTextFieldWidget extends StatelessWidget {
  final String lableText;
  final String suffixText;
  final TextInputType inputType;
  final void Function(String) onChanged;
  final List<TextInputFormatter> inputFormatters;
  const _AllOtherStaffTextFieldWidget({
    required this.lableText,
    required this.suffixText,
    required this.inputType,
    required this.onChanged,
    required this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters,
      keyboardType: inputType,
      onChanged: onChanged,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.375,
      ),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9E9E9E)),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD75755)),
        ),
        isDense: false,
        floatingLabelStyle: const TextStyle(color: Color(0xFF333333)),
        suffixIcon: Text(
          suffixText,
          style: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 16,
            fontFamily: AppFonts.ubuntu,
            fontWeight: FontWeight.w400,
            height: 1.375,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 22,
          minWidth: 24,
        ),
        label: Text(
          lableText,
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
