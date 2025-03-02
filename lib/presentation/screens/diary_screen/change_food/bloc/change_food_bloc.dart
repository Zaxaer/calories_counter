import 'package:calories_calculator/data/entity/food_data.dart';
import 'package:calories_calculator/data/repository/change_food/change_food_repo.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/change_food/bloc/change_food_event.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/change_food/bloc/change_food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeFoodBloc extends Bloc<ChangeFoodEvent, ChangeFoodState> {
  final BuildContext context;
  final ChangeFoodRepo hiveRepository;
  final int indexBox;
  ChangeFoodBloc(
    super.initialState,
    this.context,
    this.indexBox, {
    required this.hiveRepository,
  }) {
    on<ChangeFoodEvent>((event, emit) async {
      if (event is ReadChangeFoodEvent) {
        await onReadChangeFoodEvent(event, emit);
      }
      if (event is AddChangeFoodEvent) {
        await onAddChangeFoodEvent(event, emit);
      }
      if (event is ProteinChangeFoodInListEvent) {
        await onProteinChangeFoodInListEvent(event, emit);
      }
      if (event is SugarChangeFoodInListEvent) {
        await onSugarChangeFoodInListEvent(event, emit);
      }
      if (event is FatChangeFoodInListEvent) {
        await onFatChangeFoodInListEvent(event, emit);
      }
      if (event is FoodNameChangeInListEvent) {
        await onFoodNameChangeFoodInListEvent(event, emit);
      }
      if (event is CaloriesChangeFoodInListEvent) {
        await onCaloriesChangeFoodInListEvent(event, emit);
      }
    });
    add(ReadChangeFoodEvent());
  }

  Future<void> onReadChangeFoodEvent(
    ReadChangeFoodEvent event,
    Emitter<ChangeFoodState> emit,
  ) async {
    final foodData = await hiveRepository.readFoodChangeListBox(indexBox);
    if (foodData == null) return;
    final newState = state.copyWith(
      calories: foodData.calories.toString(),
      fat: foodData.fat,
      foodName: foodData.foodName,
      protein: foodData.proteint,
      sugar: foodData.sugar,
    );
    emit(newState);
  }

  Future<void> onSugarChangeFoodInListEvent(
    SugarChangeFoodInListEvent event,
    Emitter<ChangeFoodState> emit,
  ) async {
    final newState = state.copyWith(sugar: event.sugar);
    emit(newState);
  }

  Future<void> onAddChangeFoodEvent(
    AddChangeFoodEvent event,
    Emitter<ChangeFoodState> emit,
  ) async {
    final newState = state.copyWith(errorMassege: false);
    emit(newState);
    if (state.foodName.isEmpty && state.calories.isEmpty) {
      final newState = state.copyWith(errorMassege: true);
      emit(newState);
    } else {
      final foodAdd = FoodData(
        calories: double.parse(state.calories),
        foodName: state.foodName,
        fat: state.fat,
        proteint: state.protein,
        sugar: state.sugar,
      );
      hiveRepository.updateFoodListBox(indexBox, foodAdd);
      Navigator.of(context).pop();
    }
  }

  Future<void> onFatChangeFoodInListEvent(
    FatChangeFoodInListEvent event,
    Emitter<ChangeFoodState> emit,
  ) async {
    final newState = state.copyWith(fat: event.fat);
    emit(newState);
  }

  Future<void> onProteinChangeFoodInListEvent(
    ProteinChangeFoodInListEvent event,
    Emitter<ChangeFoodState> emit,
  ) async {
    final newState = state.copyWith(protein: event.protein);
    emit(newState);
  }

  Future<void> onFoodNameChangeFoodInListEvent(
    FoodNameChangeInListEvent event,
    Emitter<ChangeFoodState> emit,
  ) async {
    final newState = state.copyWith(foodName: event.foodName);
    emit(newState);
  }

  Future<void> onCaloriesChangeFoodInListEvent(
    CaloriesChangeFoodInListEvent event,
    Emitter<ChangeFoodState> emit,
  ) async {
    final newState = state.copyWith(calories: event.calories);
    emit(newState);
  }
}
