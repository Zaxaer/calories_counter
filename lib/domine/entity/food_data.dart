import 'package:hive_flutter/hive_flutter.dart';

part 'food_data.g.dart';

@HiveType(typeId: 4)
class FoodData {
  @HiveField(0)
  String foodName;
  @HiveField(1)
  double calories;
  @HiveField(2)
  String proteint;
  @HiveField(3)
  String sugar;
  @HiveField(4)
  String fat;
  FoodData({
    required this.foodName,
    required this.calories,
    required this.proteint,
    required this.sugar,
    required this.fat,
  });
}
