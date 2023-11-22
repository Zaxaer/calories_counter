import 'package:calories_calculator/domine/blocs/dairy_bloc/dairy_food_day_bloc.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/dairy_screen/dairy_screem_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/resources/resources.dart';

class DairyScreenWidget extends StatelessWidget {
  const DairyScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((DairyFoodDayBloc value) => value.state);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bloc.data,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _HeaderWidget(),
            _BodyWidget(),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFEBDBAF),
              offset: Offset(0.0, 15.0),
              blurRadius: 20.0,
            ),
          ]),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CaloriesDayWidget(),
            _ButtonAddWidget(),
          ],
        ),
      ),
    );
  }
}

class _CaloriesDayWidget extends StatelessWidget {
  const _CaloriesDayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((DairyFoodDayBloc value) => value.state);
    return Flexible(
      child: Text(
        '${bloc.caloriesDay} cal so far',
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          height: 1.485,
          fontFamily: AppFonts.mPlusRounded,
          fontStyle: FontStyle.normal,
        ),
        softWrap: false,
      ),
    );
  }
}

class _ButtonAddWidget extends StatelessWidget {
  const _ButtonAddWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DairyFoodDayBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(NextScreenFoodDayEvent()),
      child: const Text(
        'Add Something',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 1.485,
          fontFamily: AppFonts.mPlusRounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _BodyDairyWidget extends StatelessWidget {
  const _BodyDairyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((DairyFoodDayBloc value) => value.state);
    return Column(
      children: bloc.dairyList
          .asMap()
          .map(
            (index, value) {
              return MapEntry(
                index,
                _FoodNameListWidget(index: index),
              );
            },
          )
          .values
          .toList(),
    );
  }
}

class _FoodNameListWidget extends StatelessWidget {
  final int index;
  const _FoodNameListWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((DairyFoodDayBloc bloc) => bloc);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => bloc.add(DeleteFoodDayEvent(weightIndex: index)),
            backgroundColor: const Color(0xFFD75755),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${bloc.state.dairyList[index].foodName}, ${bloc.state.dairyList[index].caloriesInDay.toString()} pc ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        height: 1.333,
                        fontFamily: AppFonts.ubuntu,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    bloc.state.dairyList[index].caloriesDay.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      height: 1.333,
                      fontFamily: AppFonts.ubuntu,
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(width: 9),
                  Image.asset(AppImages.more),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFC8C8C8)),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((DairyFoodDayBloc bloc) => bloc.state);
    return Container(
      constraints: const BoxConstraints(
        minHeight: 360,
        minWidth: double.infinity,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: bloc.dairyList.isEmpty
          ? const _BodyFoodEmptyWidget()
          : const _BodyDairyWidget(),
    );
  }
}

class _BodyFoodEmptyWidget extends StatelessWidget {
  const _BodyFoodEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 97),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            AppImages.arrow,
            color: const Color(0xFF5DACE9),
            width: 75,
            height: 66,
          ),
          const SizedBox(height: 10),
          const Text(
            'Add that you ate',
            style: TextStyle(
              fontFamily: AppFonts.mPlusRounded,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
