import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:calories_calculator/domine/repository/hive_food_day_repository.dart';
import 'package:calories_calculator/ui/navigation/main_navigation.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/dairy_screen/dairy_screem_event.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/dairy_screen/dairy_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:calories_calculator/domine/entity/food_in_day.dart';

class DairyFoodDayBloc extends Bloc<FoodEvent, DairyFoodDayListState> {
  final hiveRepository = HiveRepository();
  final BuildContext context;

  DairyFoodDayBloc(super.initialState, this.context) {
    on<FoodEvent>((event, emit) async {
      if (event is ReadFoodEvent) {
        await onReadFoodEvent(event, emit);
      } else if (event is DeleteFoodDayEvent) {
        await onDeleteFoodDayEvent(event, emit);
      } else if (event is NextScreenFoodDayEvent) {
        await onNextScreenFoodDayEvent(event, emit);
      }
    }, transformer: sequential());
    add(ReadFoodEvent());
  }

  Future<void> onDeleteFoodDayEvent(
    DeleteFoodDayEvent event,
    Emitter<DairyFoodDayListState> emit,
  ) async {
    final newList = await hiveRepository.deteleFoodDayBox(event.weightIndex);
    final newState = state.copyWith(
      dairyList: newList,
      data: stringFromDate(),
      caloriesDay: _caloriesDay(newList),
    );
    emit(newState);
  }

  String stringFromDate() {
    final dateFormat = DateFormat('EEEE., d MMMM', 'ru');
    final date = dateFormat.format(DateTime.now());
    return date;
  }

  Future<void> onReadFoodEvent(
    ReadFoodEvent event,
    Emitter<DairyFoodDayListState> emit,
  ) async {
    final newList = await hiveRepository.readFoodDayBox();
    final newState = _onState(state, newList);
    emit(newState);
  }

  Future<void> onNextScreenFoodDayEvent(
    NextScreenFoodDayEvent event,
    Emitter<DairyFoodDayListState> emit,
  ) async {
    await Navigator.of(context).pushNamed(Screen.addFood);
    add(ReadFoodEvent());
  }

  DairyFoodDayListState _onState(
    DairyFoodDayListState state,
    List<FoodInDay> newList,
  ) {
    final newState = state.copyWith(
      dairyList: newList,
      data: stringFromDate(),
      caloriesDay: _caloriesDay(newList),
    );
    return newState;
  }

  String _caloriesDay(List<FoodInDay> dairyList) {
    final String calories;
    if (dairyList.isEmpty) {
      calories = '0';
      return calories;
    } else {
      final calDay = dairyList.map((e) => e.caloriesInDay * e.caloriesDay);
      final result = calDay.reduce((value, element) => value + element).toInt();
      calories = result.toString();
      return calories;
    }
  }
}
