import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_bloc.dart';
import 'package:calories_calculator/presentation/navigation/screen_factory.dart';
import 'package:flutter/material.dart';

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
  static final _screenFactory = ScreenFactory();
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
    Screen.main: (_) => _screenFactory.mainTabWidget(),
    Screen.addFood: (_) => _screenFactory.addFoodWidget(),
    // Screen.addingFoodNew: (_) => _screenFactory.addingFoodWidget(),
    Screen.addingCurrentWeight: (_) => _screenFactory.addCurrentWeighnWidget(),
    Screen.infoPerfectWeightWidget: (_) => _screenFactory.infoSumWeight(),
    Screen.learnPerfectWeightWidget:
        (_) => _screenFactory.learnPerfectWeightWidget(),
  };

  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screen.changeFood:
        final arguments = settings.arguments;
        final index = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.changeFoodWidget(index),
        );
      case Screen.addingFoodNew:
        final arguments = settings.arguments as NewFoodBloc;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.addingFoodWidget(arguments),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
