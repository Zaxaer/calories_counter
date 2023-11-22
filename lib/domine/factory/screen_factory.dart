import 'package:calories_calculator/domine/blocs/dairy_bloc/adding_new_food_bloc.dart';
import 'package:calories_calculator/domine/blocs/dairy_bloc/change_food_bloc.dart';
import 'package:calories_calculator/domine/blocs/dairy_bloc/dairy_food_day_bloc.dart';
import 'package:calories_calculator/domine/blocs/dairy_bloc/food_list_bloc.dart';
import 'package:calories_calculator/domine/blocs/main_screen_bloc/main_screen_bloc.dart';
import 'package:calories_calculator/domine/blocs/statistic_bloc/add_current_bloc.dart';
import 'package:calories_calculator/domine/blocs/statistic_bloc/learn_perfect_weight_bloc.dart';
import 'package:calories_calculator/domine/blocs/statistic_bloc/statistic_bloc.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/change_food/change_food_state.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/food_list/food_list_state.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/food_list/food_list_widget.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/adding_new_food/adding_new_food_widget.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/change_food/change_food_widget.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/dairy_screen/dairy_screen_state.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/dairy_screen/dairy_screen_widget.dart';
import 'package:calories_calculator/ui/screens/main_tab/main_screen_state.dart';
import 'package:calories_calculator/ui/screens/main_tab/main_screen_widget.dart';
import 'package:calories_calculator/ui/screens/profile/profile_widget.dart';
import 'package:calories_calculator/ui/screens/statistica/add_current_weight/add_current_state.dart';
import 'package:calories_calculator/ui/screens/statistica/add_current_weight/add_current_weight_widget.dart';
import 'package:calories_calculator/ui/screens/statistica/info_weight_sum/info_weight_sum.dart';
import 'package:calories_calculator/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_state.dart';
import 'package:calories_calculator/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_widget.dart';
import 'package:calories_calculator/ui/screens/statistica/statistic/statistic_bloc_state.dart';
import 'package:calories_calculator/ui/screens/statistica/statistic/statistic_widget.dart';
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
      create: (context) => FoodListBloc(
        const FoodListState.initialState(),
        context,
      ),
    );
  }

  Widget addingFoodWidget(AddNewFoodBloc model) {
    return BlocProvider(
      create: (context) => model,
      child: const AddNewFoodWidget(),
    );
  }

  Widget addCurrentWeighnWidget() {
    return BlocProvider(
        create: (context) => AddCurrentWeightBloc(
              const AddCurrentWeightState.initialState(),
              context,
            ),
        child: const AddCurrentWeighnWidget());
  }

  Widget statisticWidget() {
    return BlocProvider(
      create: (context) => StatisticBloc(
        const StatisticState.initialState(),
        context,
      ),
      child: const StatisticWidget(),
    );
  }

  Widget learnPerfectWeightWidget() {
    return BlocProvider(
      create: (context) => LearnPerfectWeightBloc(
        LearnPerfectWeightState.initialState(),
        context,
      ),
      child: const LearnPerfectWeightWidget(),
    );
  }

  Widget dairyScreenWidget() {
    return BlocProvider(
      create: (context) =>
          DairyFoodDayBloc(const DairyFoodDayListState.initialState(), context),
      child: const DairyScreenWidget(),
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
      create: (context) => ChangeFoodBloc(
        const ChangeFoodState.initialState(),
        context,
        index,
      ),
      child: const ChangeFoodWidget(),
    );
  }
}
