import 'package:calories_calculator/data/entity/food_in_day.dart';
import 'package:calories_calculator/data/repository/diary_food/diary_food_repo.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';

class DiaryFoodRepoLocal extends HiveRepositoryStorage
    implements DiaryFoodRepo {
  @override
  Future<List<FoodInDay>> deteleFoodDayBox(int index) async {
    final box = await openFoodDayBox();
    await box.deleteAt(index);
    final foodInDay = box.values.toList();
    return foodInDay;
  }

  @override
  Future<List<FoodInDay>> readFoodDayBox() async {
    final box = await openFoodDayBox();
    final foodInDay = box.values.toList();
    return foodInDay;
  }
}
