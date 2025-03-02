import 'package:calories_calculator/data/entity/food_data.dart';
import 'package:calories_calculator/data/repository/change_food/change_food_repo.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';
import 'package:calories_calculator/resources/configuration.dart';
import 'package:hive/hive.dart';

class ChangeFoodRepoLocal extends HiveRepositoryStorage
    implements ChangeFoodRepo {
  @override
  Future<FoodData?> readFoodChangeListBox(int index) async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodListBox)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>(Configuration.foodListBox);
    final foodBox = box.get(index);
    return foodBox;
  }

  @override
  Future<void> updateFoodListBox(int index, FoodData foodData) async {
    if (!Hive.isAdapterRegistered(Configuration.typeIDFoodListBox)) {
      Hive.registerAdapter(FoodDataAdapter());
    }
    final box = await Hive.openBox<FoodData>(Configuration.foodListBox);
    await box.put(index, foodData);
  }
}
