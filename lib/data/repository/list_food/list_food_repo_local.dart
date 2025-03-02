import 'package:calories_calculator/data/entity/food_data.dart';
import 'package:calories_calculator/data/entity/food_in_day.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';
import 'package:calories_calculator/data/repository/list_food/list_food_repo.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/list_food/bloc/list_food_state.dart';

class ListFoodLocal extends HiveRepositoryStorage implements ListFood {
  @override
  Future<List<FoodData>> readFoodListBox() async {
    final box = await openFoodListBox();
    final foodInDay = box.values.toList();
    return foodInDay;
  }

  @override
  Future<List<FoodData>> deteleFoodListBox(int index) async {
    final box = await openFoodListBox();
    await box.deleteAt(index);
    final foodInDay = box.values.toList();
    return foodInDay;
  }

  @override
  Future<int> createFoodList(int index) async {
    final box = await openFoodListBox();
    final groupKey = box.keyAt(index) as int;
    return groupKey;
  }

  @override
  Future<void> updateFoodDayBox(FoodListState state) async {
    final box = await openFoodDayBox();
    final foodInDay = FoodInDay(
      caloriesInDay: state.indexPorcies,
      foodName: state.foodName,
      caloriesDay: state.caloriesFood,
    );
    await box.add(foodInDay);
  }
}
