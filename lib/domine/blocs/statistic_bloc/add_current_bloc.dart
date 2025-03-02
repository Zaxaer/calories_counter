import 'package:calories_calculator/domine/repository/hive_food_day_repository.dart';
import 'package:calories_calculator/ui/screens/statistica/add_current_weight/add_current_event.dart';
import 'package:calories_calculator/ui/screens/statistica/add_current_weight/add_current_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCurrentWeightBloc
    extends Bloc<AddCurrentWeightEvent, AddCurrentWeightState> {
  final BuildContext context;
  final hiveRepository = HiveRepository();
  AddCurrentWeightBloc(super.initialState, this.context) {
    on<AddCurrentWeightEvent>((event, emit) {
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
    Emitter<AddCurrentWeightState> emit,
  ) {
    final newState = state.copyWith(weightText: event.weight);
    emit(newState);
  }

  void onNavigatorPopCurrentWeight() {
    Navigator.of(context).pop<String>(state.weightText);
  }

  void onSumCurrentWeightEvent(
    SumCurrentWeightEvent event,
    Emitter<AddCurrentWeightState> emit,
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
    Emitter<AddCurrentWeightState> emit,
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
