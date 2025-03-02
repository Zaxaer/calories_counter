import 'package:calories_calculator/data/repository/hive_repository.dart';
import 'package:calories_calculator/presentation/screens/diary_screen/add_new_food/bloc/new_food_state_bloc.dart';

abstract class NewFoodHiveRep extends HiveRepositoryStorage {
  Future<void> updateListFoodBox(NewFoodState state);
}
