import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:calories_calculator/domine/repository/hive_food_day_repository.dart';
import 'package:calories_calculator/ui/navigation/main_navigation.dart';
import 'package:calories_calculator/ui/screens/statistica/statistic/statistic_bloc_event.dart';
import 'package:calories_calculator/ui/screens/statistica/statistic/statistic_bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final BuildContext context;
  final hiveRepository = HiveRepository();
  StatisticBloc(StatisticState initialState, this.context)
      : super(initialState) {
    on<StatisticEvent>((event, emit) async {
      if (event is ReadStatisticEvent) {
        await onReadStatisticEventBloc(event, emit);
      }
      if (event is DeleteWeightStatisticEvent) {
        await onDeleteWeightStatisticEvent(event, emit);
      }
      if (event is LearnPerfectWeightStatisticEvent) {
        await onLearnPerfectWeightStatisticEvent(event, emit);
      }
      if (event is NavigatorAddCurrentWeightStatisticEvent) {
        await onNavigatorAddCurrentWeightStatisticEvent(event, emit);
      }
      if (event is WeightInputStatisticEvent) {
        await onWeightInputStatisticEvent(event, emit);
      }
    }, transformer: sequential());

    add(ReadStatisticEvent());
  }

  Future<void> onReadStatisticEventBloc(
    ReadStatisticEvent event,
    Emitter<StatisticState> emit,
  ) async {
    final newBox = await hiveRepository.openStatisticBox();
    final newState = state.copyWith(weight: newBox);
    emit(newState);
  }

  Future<void> onWeightInputStatisticEvent(
    WeightInputStatisticEvent event,
    Emitter<StatisticState> emit,
  ) async {
    final newState = state.copyWith(weightInput: event.weight);
    emit(newState);
  }

  Future<void> onDeleteWeightStatisticEvent(
    DeleteWeightStatisticEvent event,
    Emitter<StatisticState> emit,
  ) async {
    await hiveRepository.deleteStatisticBox(event.index, state);
    add(ReadStatisticEvent());
  }

  Future<void> onNavigatorAddCurrentWeightStatisticEvent(
    NavigatorAddCurrentWeightStatisticEvent event,
    Emitter<StatisticState> emit,
  ) async {
    final weightResult =
        await Navigator.of(context).pushNamed(Screen.addingCurrentWeight);
    await hiveRepository.saveWeightBox(state, weightResult as String);
    add(ReadStatisticEvent());
  }

  Future<void> onLearnPerfectWeightStatisticEvent(
    LearnPerfectWeightStatisticEvent event,
    Emitter<StatisticState> emit,
  ) async {
    final result = await Navigator.of(context)
            .pushNamed(Screen.learnPerfectWeightWidget) ??
        '';
    final newState = state.copyWith(perfectWeight: result as String);
    emit(newState);
    hiveRepository.learnPerfectWeightStatisticBox(state);
    add(ReadStatisticEvent());
  }
}
