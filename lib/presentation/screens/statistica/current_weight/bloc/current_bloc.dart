import 'package:calories_calculator/presentation/screens/statistica/current_weight/bloc/current_event.dart';
import 'package:calories_calculator/presentation/screens/statistica/current_weight/bloc/current_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeightBloc extends Bloc<CurrentWeightEvent, CurrentWeightState> {
  final BuildContext context;
  CurrentWeightBloc(super.initialState, this.context) {
    on<CurrentWeightEvent>((event, emit) {
      if (event is DiffCurrentWeightEvent) {
        onDiffCurrentWeightEvent(event, emit);
      }
      if (event is SumCurrentWeightEvent) {
        onSumCurrentWeightEvent(event, emit);
      }
      if (event is NavigatorPopCurrentWeight) {
        onNavigatorPopCurrentWeight();
      }
      if (event is InputCurrentWeightEvent) {
        onInputCurrentWeightEvent(event, emit);
      }
    });
  }

  void onInputCurrentWeightEvent(
    InputCurrentWeightEvent event,
    Emitter<CurrentWeightState> emit,
  ) {
    final newState = state.copyWith(weightText: event.weight);
    emit(newState);
  }

  void onNavigatorPopCurrentWeight() {
    Navigator.of(context).pop<String>(state.weightText);
  }

  void onSumCurrentWeightEvent(
    SumCurrentWeightEvent event,
    Emitter<CurrentWeightState> emit,
  ) {
    final intWeight = int.parse(state.weightText);

    if (intWeight >= 1) {
      final newState = state.copyWith(
        weightText: (int.parse(state.weightText) + 1).toString(),
      );
      emit(newState);
    }
  }

  void onDiffCurrentWeightEvent(
    DiffCurrentWeightEvent event,
    Emitter<CurrentWeightState> emit,
  ) {
    final intWeight = int.parse(state.weightText);
    if (intWeight > 1) {
      final newState = state.copyWith(weightText: ((intWeight - 1).toString()));
      emit(newState);
    } else if (intWeight == 1) {
      return;
    }
  }
}
