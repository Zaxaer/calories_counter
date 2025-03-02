import 'package:calories_calculator/data/entity/food_data.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/list_food/bloc/list_food_state.dart';

abstract class ListFood extends HiveRepositoryStorage {
  Future<List<FoodData>> readFoodListBox();

  Future<List<FoodData>> deteleFoodListBox(int index);

  Future<int> createFoodList(int index);

  Future<void> updateFoodDayBox(FoodListState state);
}
