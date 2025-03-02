import 'package:calories_calculator/ui/screens/main_tab/main_screen_event.dart';
import 'package:calories_calculator/ui/screens/main_tab/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc(super.initialState) {
    on<MainScreenEvent>((event, emit) {
      if (event is SelectScreen) {
        onSelectScreen(event, emit);
      }
    });
  }

  void onSelectScreen(SelectScreen event, Emitter<MainScreenState> emit) {
    if (event.index == state.currentTabIndex) return;
    final newState = state.copyWith(currentTabIndex: event.index);
    emit(newState);
  }
}
