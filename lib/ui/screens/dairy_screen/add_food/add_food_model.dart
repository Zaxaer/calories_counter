import 'package:calorie_calculator_exemple/domine/entity/food_data.dart';
import 'package:calorie_calculator_exemple/domine/entity/food_in_day.dart';
import 'package:calorie_calculator_exemple/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddFoodModel extends ChangeNotifier {
  var _foodALLData = <FoodData>[];
  List<FoodData> get foodAllData => _foodALLData.toList();
  int selectedIndex = -1;
  int selectedIndexSum = -1;
  String _foodName = '';
  double _caloriesFood = 0;
  int _porcionIndex = 0;
  int indexPorcies = 1;

  AddFoodModel() {
    _setup();
  }

  void runFilter(String enteredKeyword) async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>('foodData_box');
    _readGroupsFromHive(box);
    List<FoodData> results = [];
    if (enteredKeyword.isEmpty) {
      results = _foodALLData;
    } else {
      results = _foodALLData
          .where((food) => food.foodName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      _foodALLData = results;
    }
    notifyListeners();
  }

  void diffIndex(int index) {
    if (selectedIndex == index) {
      selectedIndexSum = index;
      if (indexPorcies > 1) {
        indexPorcies -= 1;
      } else if (indexPorcies == 1) {
        return;
      }
    }
    notifyListeners();
  }

  void sumIndex(int index) {
    if (selectedIndex == index) {
      selectedIndexSum = index;
      if (indexPorcies >= 1) {
        indexPorcies += 1;
      } else if (indexPorcies == 1) {
        return;
      }
    }
    notifyListeners();
  }

  void changeFoodData(BuildContext context, int groupIndex) async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>('foodData_box');
    final groupKey = box.keyAt(groupIndex) as int;
    await Navigator.of(context)
        .pushNamed(Screen.changeFood, arguments: groupKey);
  }

  void isSelectedTable(
      int index, int indexPC, String foodName, double caloriesDayFood) {
    if (selectedIndex == index) {
      selectedIndex = -1;
      _foodName = '';

      _caloriesFood = 0;
    } else {
      indexPorcies = 1;
      selectedIndex = index;
      _foodName = foodName;
      _porcionIndex = indexPC;
      _caloriesFood = caloriesDayFood;
    }
    notifyListeners();
  }

  void foodInDay(BuildContext context) async {
    if (_foodName == '' || _porcionIndex == 0 || _caloriesFood == 0) {
      Navigator.of(context).pop();
    } else {
      if (!Hive.isAdapterRegistered(5)) {
        Hive.registerAdapter(FoodInDayAdapter());
      }
      _porcionIndex = indexPorcies;
      final box = await Hive.openBox<FoodInDay>('foodDay_box');
      final foodInDay = FoodInDay(
          caloriesInDay: _porcionIndex,
          foodName: _foodName,
          caloriesDay: _caloriesFood);

      await box.add(foodInDay);
      Navigator.of(context).pop();
    }
  }

  void deleteGroup(int weightIndex) async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>('foodData_box');
    await box.deleteAt(weightIndex);
  }

  void _readGroupsFromHive(Box<FoodData> box) async {
    _foodALLData = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>('foodData_box');
    // box.clear();
    _readGroupsFromHive(box);
    box.listenable().addListener(() => _readGroupsFromHive(box));
  }
}
