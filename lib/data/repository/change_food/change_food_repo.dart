import 'package:calories_calculator/data/entity/food_data.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';

abstract class ChangeFoodRepo extends HiveRepositoryStorage {
  Future<FoodData?> readFoodChangeListBox(int index);
  Future<void> updateFoodListBox(int index, FoodData foodData);
}
