import 'package:hive_flutter/hive_flutter.dart';

part 'food_in_day.g.dart';

@HiveType(typeId: 5)
class FoodInDay {
  @HiveField(0)
  int caloriesInDay;
  @HiveField(1)
  String foodName;
  @HiveField(2)
  double caloriesDay;
  FoodInDay({
    required this.caloriesInDay,
    required this.foodName,
    required this.caloriesDay,
  });
}
