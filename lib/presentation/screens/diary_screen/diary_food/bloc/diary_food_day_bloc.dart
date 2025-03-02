import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:calories_calculator/data/repository/diary_food/diary_food_repo.dart';
import 'package:calories_calculator/presentation/navigation/main_navigation.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/diary_food/bloc/diary_screem_event.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/diary_food/bloc/diary_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:calories_calculator/data/entity/food_in_day.dart';

class DiaryFoodDayBloc extends Bloc<FoodEvent, DiaryFoodDayListState> {
  final DiaryFoodRepo hiveRepository;
  final BuildContext context;

  DiaryFoodDayBloc(
    super.initialState,
    this.context, {
    required this.hiveRepository,
  }) {
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
    Emitter<DiaryFoodDayListState> emit,
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
    Emitter<DiaryFoodDayListState> emit,
  ) async {
    final newList = await hiveRepository.readFoodDayBox();
    final newState = _onState(state, newList);
    emit(newState);
  }

  Future<void> onNextScreenFoodDayEvent(
    NextScreenFoodDayEvent event,
    Emitter<DiaryFoodDayListState> emit,
  ) async {
    await Navigator.of(context).pushNamed(Screen.addFood);
    add(ReadFoodEvent());
  }

  DiaryFoodDayListState _onState(
    DiaryFoodDayListState state,
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
