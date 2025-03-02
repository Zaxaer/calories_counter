import 'package:calories_calculator/data/entity/food_data.dart';
import 'package:calories_calculator/data/entity/food_in_day.dart';
import 'package:calories_calculator/resources/configuration.dart';
import 'package:hive/hive.dart';

class HiveRepositoryStorage {
  Future<Box<FoodData>> openFoodListBox() async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodListBox)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>(Configuration.foodListBox);
    return box;
  }

  Future<Box<FoodInDay>> openFoodDayBox() async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodDayBox)) {
      Hive.registerAdapter(FoodInDayAdapter());
    }
    final box = await Hive.openBox<FoodInDay>(Configuration.fooDayBox);
    return box;
  }
}
