import 'package:calories_calculator/data/entity/food_data.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';
import 'package:calories_calculator/data/repository/new_food/new_food_rep.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_state_bloc.dart';

class NewFoodRepLocal extends HiveRepositoryStorage implements NewFoodHiveRep {
  @override
  Future<void> updateListFoodBox(NewFoodState state) async {
    final box = await openFoodListBox();
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
