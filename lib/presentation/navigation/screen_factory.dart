import 'package:calories_calculator/data/repository/change_food/change_food_repo_local.dart';
import 'package:calories_calculator/data/repository/diary_food/diary_food_repo_local.dart';
import 'package:calories_calculator/data/repository/list_food/list_food_repo_local.dart';
import 'package:calories_calculator/data/repository/statistica/statistica_repo_loca.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_bloc.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/change_food/bloc/change_food_bloc.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/diary_food/bloc/diary_food_day_bloc.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/list_food/bloc/list_food_bloc.dart';
import 'package:calories_calculator/presentation/screens/statistica/current_weight/bloc/current_bloc.dart';
import 'package:calories_calculator/presentation/screens/statistica/perfect_weight/bloc/perfect_weight_bloc.dart';
import 'package:calories_calculator/presentation/screens/statistica/statistic/bloc/statistic_bloc.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/change_food/bloc/change_food_state.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/diary_food/bloc/diary_screen_state.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/list_food/bloc/list_food_state.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/list_food/page/list_food_widget.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/page/new_food_widget.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/change_food/page/change_food_widget.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/diary_food/page/diary_screen_widget.dart';
import 'package:calories_calculator/presentation/screens/main_tab/bloc/main_screen_bloc.dart';
import 'package:calories_calculator/presentation/screens/main_tab/bloc/main_screen_state.dart';
import 'package:calories_calculator/presentation/screens/main_tab/page/main_screen_widget.dart';
import 'package:calories_calculator/presentation/screens/profile/profile_widget.dart';
import 'package:calories_calculator/presentation/screens/statistica/current_weight/bloc/current_state.dart';
import 'package:calories_calculator/presentation/screens/statistica/current_weight/page/current_weight_widget.dart';
import 'package:calories_calculator/presentation/screens/statistica/info_weight_sum/page/info_weight_sum.dart';
import 'package:calories_calculator/presentation/screens/statistica/perfect_weight/bloc/perfect_weight_state.dart';
import 'package:calories_calculator/presentation/screens/statistica/perfect_weight/page/perfect_weight_widget.dart';
import 'package:calories_calculator/presentation/screens/statistica/statistic/bloc/statistic_bloc_state.dart';
import 'package:calories_calculator/presentation/screens/statistica/statistic/page/statistic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenFactory {
  Widget mainTabWidget() {
    return BlocProvider(
      create: (_) => MainScreenBloc(MainScreenState.initialState()),
      child: MainScreenWidget(screenFactory: this),
    );
  }

  Widget addFoodWidget() {
    return BlocProvider(
      child: const ListFoodWidget(),
      create:
          (context) => FoodListBloc(
            const FoodListState.initialState(),
            context,
            hiveRepository: ListFoodLocal(),
          ),
    );
  }

  Widget addingFoodWidget(NewFoodBloc model) {
    return BlocProvider(
      create: (context) => model,
      child: const AddNewFoodWidget(),
    );
  }

  Widget addCurrentWeighnWidget() {
    return BlocProvider(
      create:
          (context) => CurrentWeightBloc(
            const CurrentWeightState.initialState(),
            context,
          ),
      child: const CurrentWeighnWidget(),
    );
  }

  Widget statisticWidget() {
    return BlocProvider(
      create:
          (context) => StatisticBloc(
            const StatisticState.initialState(),
            context,
            repository: StatisticaRepoLoca(),
          ),
      child: const StatisticWidget(),
    );
  }

  Widget learnPerfectWeightWidget() {
    return BlocProvider(
      create:
          (context) =>
              PerfectWeightBloc(PerfectWeightState.initialState(), context),
      child: const LearnPerfectWeightWidget(),
    );
  }

  Widget dairyScreenWidget() {
    return BlocProvider(
      create:
          (context) => DiaryFoodDayBloc(
            hiveRepository: DiaryFoodRepoLocal(),
            const DiaryFoodDayListState.initialState(),
            context,
          ),
      child: const DiaryScreenWidget(),
    );
  }

  Widget infoSumWeight() {
    return const InfoSumWeight();
  }

  Widget profileWidget() {
    return const ProfileWidget();
  }

  Widget changeFoodWidget(int index) {
    return BlocProvider(
      create:
          (context) => ChangeFoodBloc(
            hiveRepository: ChangeFoodRepoLocal(),
            const ChangeFoodState.initialState(),
            context,
            index,
          ),
      child: const ChangeFoodWidget(),
    );
  }
}
