import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:calories_calculator/domine/blocs/dairy_bloc/adding_new_food_bloc.dart';
import 'package:calories_calculator/domine/entity/food_data.dart';
import 'package:calories_calculator/domine/repository/hive_food_day_repository.dart';
import 'package:calories_calculator/ui/navigation/main_navigation.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/adding_new_food/adding_new_food_state_bloc.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/food_list/food_list_event.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/food_list/food_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodListBloc extends Bloc<FoodListEvent, FoodListState> {
  final BuildContext context;
  final hiveRepository = HiveRepository();
  FoodListBloc(super.initialState, this.context) {
    on<FoodListEvent>((event, emit) async {
      if (event is ReadFoodListEvent) {
        await onReadFoodListEvent(event, emit);
      }
      if (event is ChangeFoodEvent) {
        await onChangeFoodEvent(event, emit);
      }
      if (event is DiffPorciesEvent) {
        await onDiffPorciesEvent(event, emit);
      }
      if (event is SumPorciesEvent) {
        await onSumPorciesEvent(event, emit);
      }
      if (event is DeleteFoodEvent) {
        await onDeleteFoodListEvent(event, emit);
      }
      if (event is AddNewFoodEvent) {
        await onAddNewFoodListEvent(event, emit);
      }
      if (event is SelectTableFoodListEvent) {
        await onSelectTableFoodListEvent(event, emit);
      }
      if (event is AddDayFoodListEvent) {
        await onAddDayFoodListEvent(event, emit);
      }
      if (event is SearchFoodListEvent) {
        await onSearchFoodListEvent(event, emit);
      }
      if (event is ExpansionTileEvent) {
        await onExpansionTileEvent(event, emit);
      }
    }, transformer: sequential());
    add(ReadFoodListEvent());
  }

  Future<void> onExpansionTileEvent(
    ExpansionTileEvent event,
    Emitter<FoodListState> emit,
  ) async {
    final newState = state.copyWith(isExpanded: !state.isExpanded);
    emit(newState);
  }

  Future<void> onReadFoodListEvent(
    ReadFoodListEvent event,
    Emitter<FoodListState> emit,
  ) async {
    final newList = await hiveRepository.readFoodListBox();
    final newState = _onState(state, newList);
    emit(newState);
  }

  Future<void> onDeleteFoodListEvent(
    DeleteFoodEvent event,
    Emitter<FoodListState> emit,
  ) async {
    final newList = await hiveRepository.deteleFoodListBox(event.index);
    final newState = _onState(state, newList);
    emit(newState);
  }

  Future<void> onAddNewFoodListEvent(
    AddNewFoodEvent event,
    Emitter<FoodListState> emit,
  ) async {
    await Navigator.of(context).pushNamed(
      Screen.addingFoodNew,
      arguments: AddNewFoodBloc(
        const AddingNewFoodState.initialState(),
        context,
      ),
    );
    add(ReadFoodListEvent());
  }

  Future<void> onChangeFoodEvent(
    ChangeFoodEvent event,
    Emitter<FoodListState> emit,
  ) async {
    final boxKey = await hiveRepository.changeFood(event.index);
    if (!context.mounted) return;
    await Navigator.of(context).pushNamed(Screen.changeFood, arguments: boxKey);
    add(ReadFoodListEvent());
  }

  Future<void> onSelectTableFoodListEvent(
    SelectTableFoodListEvent event,
    Emitter<FoodListState> emit,
  ) async {
    if (state.selectedIndex == event.index) {
      final newState = state.copyWith(
        selectedIndex: -1,
        foodName: '',
        caloriesFood: 0,
      );
      emit(newState);
    } else {
      final newState = state.copyWith(
        selectedIndex: event.index,
        indexPorcies: 1,
        foodName: event.foodName,
        porcionIndex: state.indexPorcies,
        caloriesFood: event.caloriesDayFood,
      );
      emit(newState);
    }
  }

  Future<void> onDiffPorciesEvent(
    DiffPorciesEvent event,
    Emitter<FoodListState> emit,
  ) async {
    if (state.selectedIndex == event.index) {
      final newState = state.copyWith(selectedIndexSum: event.index);
      emit(newState);
      if (state.indexPorcies > 1) {
        final newState = state.copyWith(indexPorcies: state.indexPorcies - 1);
        emit(newState);
      } else if (state.indexPorcies == 1) {
        return;
      }
    }
  }

  Future<void> onSumPorciesEvent(
    SumPorciesEvent event,
    Emitter<FoodListState> emit,
  ) async {
    if (state.selectedIndex == event.index) {
      final newState = state.copyWith(selectedIndexSum: event.index);
      emit(newState);
      if (state.indexPorcies >= 1) {
        final newState = state.copyWith(indexPorcies: state.indexPorcies + 1);
        emit(newState);
      } else if (state.indexPorcies == 1) {
        return;
      }
    }
  }

  Future<void> onAddDayFoodListEvent(
    AddDayFoodListEvent event,
    Emitter<FoodListState> emit,
  ) async {
    if (state.foodName == '' ||
        state.indexPorcies == 0 ||
        state.caloriesFood == 0) {
      Navigator.of(context).pop();
    } else {
      hiveRepository.addFoodDayBox(state);
      Navigator.of(context).pop();
    }
  }

  Future<void> onSearchFoodListEvent(
    SearchFoodListEvent event,
    Emitter<FoodListState> emit,
  ) async {
    List<FoodData> results = [];
    final newList = await hiveRepository.readFoodListBox();
    if (event.enteredKeyword.isEmpty) {
      final newState = _onState(state, newList);
      emit(newState);
    } else {
      results =
          newList
              .where(
                (food) => food.foodName.toLowerCase().contains(
                  event.enteredKeyword.toLowerCase(),
                ),
              )
              .toList();
      final newState = state.copyWith(listFood: results);
      emit(newState);
    }
  }

  FoodListState _onState(FoodListState state, List<FoodData> newList) {
    final newState = state.copyWith(listFood: newList);
    return newState;
  }
}
