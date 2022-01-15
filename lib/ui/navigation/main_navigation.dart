import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/add_food/add_food_model.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/add_food/add_food_widget.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/adding_new_food/adding_new_food_model.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/adding_new_food/adding_new_food_widget.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/adding_new_food/change_food_widget.dart';
import 'package:calorie_calculator_exemple/ui/screens/main_tab/main_tab_model.dart';
import 'package:calorie_calculator_exemple/ui/screens/main_tab/main_tab_widget.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/add_current_weight/add_current_weight_widget.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/info_weight_sum.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/statistic/statistic_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Screen {
  static const main = '/';
  static const addFood = '/addFood';
  static const addingFoodNew = '/addingFoodNew';
  static const addingCurrentWeight = '/addingCurrentWeight';
  static const learnPerfectWeightWidget = '/learnPerfectWeightWidget';
  static const infoPerfectWeightWidget = '/infoPerfectWeightWidget';
  static const changeFood = '/changeFood';
}

class MainNavigation {
  final statisticModel = StatisticModel();
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        Screen.main: (_) => ChangeNotifierProvider(
              create: (_) => MainTabModel(),
              child: MainTabsScreenWidget(),
            ),
        Screen.addFood: (_) => ChangeNotifierProvider(
              child: const AddFoodWidget(),
              create: (_) => AddFoodModel(),
            ),
        Screen.addingFoodNew: (_) => ChangeNotifierProvider(
            create: (_) => AddingNewFoodWidgetModel(),
            child: const AddingNewFoodWidget()),
        Screen.addingCurrentWeight: (_) => ChangeNotifierProvider.value(
            value: statisticModel, child: const AddCurrentWeighnWidget()),
        Screen.infoPerfectWeightWidget: (_) => const InfoSumWeight(),
        Screen.changeFood: (_) => const ChangeFoodWidget(),
      };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
}
