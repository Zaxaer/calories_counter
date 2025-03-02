import 'package:calories_calculator/data/repository/new_food/new_food_rep.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_event.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_state_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewFoodBloc extends Bloc<NewFoodEvent, NewFoodState> {
  final BuildContext context;
  final NewFoodHiveRep hiveRepository;
  NewFoodBloc(
    super.initialState,
    this.context, {
    required this.hiveRepository,
  }) {
    on<NewFoodEvent>((event, emit) async {
      if (event is AddNewFoodInListEvent) {
        await onAddingNewFoodInListEvent(event, emit);
      }
      if (event is ProteinFoodInListEvent) {
        await onProteinFoodInListEvent(event, emit);
      }
      if (event is SugarFoodInListEvent) {
        await onSugarFoodInListEvent(event, emit);
      }
      if (event is FatFoodInListEvent) {
        await onFatFoodInListEvent(event, emit);
      }
      if (event is FoodNameInListEvent) {
        await onFoodNameFoodInListEvent(event, emit);
      }
      if (event is CaloriesFoodInListEvent) {
        await onCaloriesFoodInListEvent(event, emit);
      }
    });
  }

  Future<void> onProteinFoodInListEvent(
    ProteinFoodInListEvent event,
    Emitter<NewFoodState> emit,
  ) async {
    final newState = state.copyWith(protein: event.protein);
    emit(newState);
  }

  Future<void> onSugarFoodInListEvent(
    SugarFoodInListEvent event,
    Emitter<NewFoodState> emit,
  ) async {
    final newState = state.copyWith(sugar: event.sugar);
    emit(newState);
  }

  Future<void> onFatFoodInListEvent(
    FatFoodInListEvent event,
    Emitter<NewFoodState> emit,
  ) async {
    final newState = state.copyWith(fat: event.fat);
    emit(newState);
  }

  Future<void> onFoodNameFoodInListEvent(
    FoodNameInListEvent event,
    Emitter<NewFoodState> emit,
  ) async {
    final newState = state.copyWith(foodName: event.foodName);
    emit(newState);
  }

  Future<void> onCaloriesFoodInListEvent(
    CaloriesFoodInListEvent event,
    Emitter<NewFoodState> emit,
  ) async {
    final newState = state.copyWith(calories: event.calories);
    emit(newState);
  }

  Future<void> onAddingNewFoodInListEvent(
    AddNewFoodInListEvent event,
    Emitter<NewFoodState> emit,
  ) async {
    final newState = state.copyWith(errorMassege: false);
    emit(newState);
    if (state.foodName.isEmpty && state.calories.isEmpty) {
      final newState = state.copyWith(errorMassege: true);
      emit(newState);
    } else {
      await hiveRepository.updateListFoodBox(state);
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }
  }
}
