import 'package:calories_calculator/data/entity/food_in_day.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';

abstract class DiaryFoodRepo extends HiveRepositoryStorage {
  Future<List<FoodInDay>> deteleFoodDayBox(int index);

  Future<List<FoodInDay>> readFoodDayBox();
}
