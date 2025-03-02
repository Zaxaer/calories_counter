import 'package:calories_calculator/ui/navigation/main_navigation.dart';
import 'package:calories_calculator/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_event.dart';
import 'package:calories_calculator/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnPerfectWeightBloc
    extends Bloc<LearnPerfectWeightEvent, LearnPerfectWeightState> {
  final BuildContext context;
  LearnPerfectWeightBloc(super.initialState, this.context) {
    on<LearnPerfectWeightEvent>((event, emit) {
      if (event is InputAgeLearnPerfectWeightEvent) {
        onInputAgeLearnPerfectWeight(event, emit);
      }
      if (event is InputGrowthLearnPerfectWeightEvent) {
        onInputGrowthLearnPerfectWeight(event, emit);
      }
      if (event is GenderSelectLearnPerfectWeightEvent) {
        onGenderSelectLearnPerfectWeight(event, emit);
      }
      if (event is ResultLearnPerfectWeightEvent) {
        onResultLearnPerfectWeight(event, emit);
      }
      if (event is NavigatopPopLearnPerfectWeightEvent) {
        onNavigatopPopLearnPerfectWeightEvent(event, emit);
      }
      if (event is NavigatopInfoLearnPerfectWeightEvent) {
        onNavigatopInfoLearnPerfectWeightEvent(event, emit);
      }
    });
  }

  void onInputAgeLearnPerfectWeight(
    InputAgeLearnPerfectWeightEvent event,
    Emitter<LearnPerfectWeightState> emit,
  ) {
    final newState = state.copyWith(ege: event.textInput);
    emit(newState);
  }

  void onNavigatopInfoLearnPerfectWeightEvent(
    NavigatopInfoLearnPerfectWeightEvent event,
    Emitter<LearnPerfectWeightState> emit,
  ) {
    Navigator.of(context).pushNamed(Screen.infoPerfectWeightWidget);
  }

  void onNavigatopPopLearnPerfectWeightEvent(
    NavigatopPopLearnPerfectWeightEvent event,
    Emitter<LearnPerfectWeightState> emit,
  ) {
    Navigator.pop(context, state.perfectWeight);
  }

  void onInputGrowthLearnPerfectWeight(
    InputGrowthLearnPerfectWeightEvent event,
    Emitter<LearnPerfectWeightState> emit,
  ) {
    final newState = state.copyWith(hight: event.textInput);
    emit(newState);
  }

  void onGenderSelectLearnPerfectWeight(
    GenderSelectLearnPerfectWeightEvent event,
    Emitter<LearnPerfectWeightState> emit,
  ) {
    for (
      int buttonIndex = 0;
      buttonIndex < state.isSelected.length;
      buttonIndex++
    ) {
      if (buttonIndex == event.indexGender) {
        final newList = List<bool>.from(state.isSelected);
        newList[buttonIndex] = true;
        final newState = state.copyWith(isSelected: newList);
        emit(newState);
      } else {
        final newList = List<bool>.from(state.isSelected);
        newList[buttonIndex] = false;
        final newState = state.copyWith(isSelected: newList);
        emit(newState);
      }
    }
  }

  void onResultLearnPerfectWeight(
    ResultLearnPerfectWeightEvent event,
    Emitter<LearnPerfectWeightState> emit,
  ) {
    if (state.ege.isEmpty || state.hight.isEmpty) return;
    final egeInt = int.parse(state.ege);
    final hightInt = int.parse(state.hight);
    if (state.isSelected[0] == true) {
      // female
      if (egeInt <= 20) {
        final newState = state.copyWith(
          perfectWeight: (hightInt - 100).toString(),
        );
        emit(newState);
      }
      if (egeInt <= 30 || egeInt >= 20) {
        final newState = state.copyWith(
          perfectWeight:
              ((hightInt - 100) - ((hightInt - 100) * 0.11)).toString(),
        );
        emit(newState);
      }
      if (egeInt >= 50) {
        final newState = state.copyWith(
          perfectWeight:
              ((hightInt - 100) + ((hightInt - 100) * 0.06)).toString(),
        );
        emit(newState);
      }
    }
    if (state.isSelected[1] == true) {
      // Male
      if (egeInt <= 20) {
        final newState = state.copyWith(
          perfectWeight: (hightInt - 110).toString(),
        );
        emit(newState);
      }
      if (egeInt <= 30 || egeInt >= 20) {
        final newState = state.copyWith(
          perfectWeight:
              ((hightInt - 110) - ((hightInt - 110) * 0.11)).toString(),
        );
        emit(newState);
      }
      if (egeInt >= 50) {
        final newState = state.copyWith(
          perfectWeight:
              ((hightInt - 110) + ((hightInt - 110) * 0.06)).toString(),
        );
        emit(newState);
      }
    }
  }
}
