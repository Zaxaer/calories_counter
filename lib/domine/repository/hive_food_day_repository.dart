import 'package:calories_calculator/domine/entity/weight.dart';
import 'package:calories_calculator/ui/screens/statistica/statistic/statistic_bloc_state.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:calories_calculator/domine/configuration/configuration.dart';
import 'package:calories_calculator/domine/entity/food_data.dart';
import 'package:calories_calculator/domine/entity/food_in_day.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/adding_new_food/adding_new_food_state_bloc.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/food_list/food_list_state.dart';

class HiveRepository {
  Future<List<FoodInDay>> readFoodDayBox() async {
    final box = await _openFoodDayBox();
    final foodInDay = box.values.toList();
    return foodInDay;
  }

  Future<List<FoodData>> deteleFoodListBox(int index) async {
    final box = await _openFoodListBox();
    await box.deleteAt(index);
    final foodInDay = box.values.toList();
    return foodInDay;
  }

  Future<Box<FoodInDay>> _openFoodDayBox() async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodDayBox)) {
      Hive.registerAdapter(FoodInDayAdapter());
    }
    final box = await Hive.openBox<FoodInDay>(Configuration.fooDayBox);
    return box;
  }

  Future<Box<FoodData>> _openFoodListBox() async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodListBox)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>(Configuration.foodListBox);
    return box;
  }

  Future<FoodData?> openFoodChangeListBox(int index) async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodListBox)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>(Configuration.foodListBox);
    final foodBox = box.get(index);
    return foodBox;
  }

  Future<List<WeightStatistic>> openStatisticBox() async {
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);
    final statisticList = box.values.toList();
    return statisticList;
  }

  Future<void> learnPerfectWeightStatisticBox(StatisticState state) async {
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    if (state.perfectWeight == '') return;
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);

    final perfectWeightInt = WeightStatistic(
        weight: double.parse(state.perfectWeight), isPrefectWeight: true);
    await box.add(perfectWeightInt);
  }

  Future<void> deleteStatisticBox(int index, StatisticState state) async {
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);
    if (state.weight.last.isPrefectWeight == true &&
        state.weight.length == 2 &&
        index == 0) {
      box.clear();
    } else {
      await box.deleteAt(index);
    }
  }

  Future<void> saveWeightBox(StatisticState state, String weightInput) async {
    if (weightInput == '1' || weightInput == '') return;
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);
    if (state.weight.isEmpty) {
      final weightInt = WeightStatistic(
          weight: double.parse(weightInput), isPrefectWeight: false);
      await box.add(weightInt);
    } else if (state.weight.last.isPrefectWeight == false) {
      final weightInt = WeightStatistic(
          weight: double.parse(weightInput), isPrefectWeight: false);
      await box.add(weightInt);
    } else if (state.weight.last.isPrefectWeight == true) {
      final lastElement = box.values.last;
      final lastKey = box.keys.last as int;
      box.delete(lastKey);
      final weightInt = WeightStatistic(
          weight: double.parse(weightInput), isPrefectWeight: false);
      await box.add(weightInt);
      await box.add(lastElement);
    }
  }

  Future<void> changeFoodListBox(int index, FoodData foodData) async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodListBox)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>(Configuration.foodListBox);
    await box.put(index, foodData);
  }

  Future<List<FoodInDay>> deteleFoodDayBox(int index) async {
    final box = await _openFoodDayBox();
    await box.deleteAt(index);
    final foodInDay = box.values.toList();
    return foodInDay;
  }

  Future<List<FoodData>> readFoodListBox() async {
    final box = await _openFoodListBox();
    final foodInDay = box.values.toList();
    return foodInDay;
  }

  Future<int> changeFood(int index) async {
    final box = await _openFoodListBox();
    final groupKey = box.keyAt(index) as int;
    return groupKey;
  }

  Future<void> addFoodDayBox(FoodListState state) async {
    final box = await _openFoodDayBox();
    final foodInDay = FoodInDay(
      caloriesInDay: state.indexPorcies,
      foodName: state.foodName,
      caloriesDay: state.caloriesFood,
    );
    await box.add(foodInDay);
  }

  Future<void> addFoodListBox(AddingNewFoodState state) async {
    final box = await _openFoodListBox();
    final foodList = FoodData(
      foodName: state.foodName,
      calories: double.parse(state.calories),
      fat: state.fat,
      proteint: state.protein,
      sugar: state.sugar,
    );
    await box.add(foodList);
  }
}
