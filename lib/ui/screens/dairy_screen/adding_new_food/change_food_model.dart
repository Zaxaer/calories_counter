import 'package:calorie_calculator_exemple/domine/entity/food_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChangeFoodWidgetModel extends ChangeNotifier {
  int groupKey;
  String foodName = '';
  String calories = '';
  String protein = '';
  String sugar = '';
  String fat = '';
  bool errorMassege = false;
  ChangeFoodWidgetModel({required this.groupKey}) {
    data();
  }
  void data() async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>('foodData_box');
    if (box.isEmpty) {
      return;
    } else {
      final foodData = box.get(groupKey);
      foodName = foodData!.foodName;
      calories = foodData.calories.toString();
      protein = foodData.proteint;
      sugar = foodData.sugar;
      fat = foodData.fat;
    }
    notifyListeners();
  }

  void addFoodData(BuildContext context) async {
    errorMassege = false;
    if (foodName.isEmpty && calories.isEmpty) {
      errorMassege = true;
      notifyListeners();
    } else {
      if (!Hive.isAdapterRegistered(4)) {
        Hive.registerAdapter(FoodDataAdapter());
      }
      final box = await Hive.openBox<FoodData>('foodData_box');
      final foodAdd = FoodData(
          calories: double.parse(calories),
          foodName: foodName,
          fat: fat,
          proteint: protein,
          sugar: sugar);
      await box.put(groupKey, foodAdd);

      Navigator.of(context).pop();
    }
  }
}
