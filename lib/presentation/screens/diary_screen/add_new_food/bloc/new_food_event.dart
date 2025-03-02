class NewFoodEvent {}

class AddNewFoodInListEvent extends NewFoodEvent {}

class ProteinFoodInListEvent extends NewFoodEvent {
  final String protein;
  ProteinFoodInListEvent({required this.protein});
}

class SugarFoodInListEvent extends NewFoodEvent {
  final String sugar;
  SugarFoodInListEvent({required this.sugar});
}

class FatFoodInListEvent extends NewFoodEvent {
  final String fat;
  FatFoodInListEvent({required this.fat});
}

class FoodNameInListEvent extends NewFoodEvent {
  final String foodName;
  FoodNameInListEvent({required this.foodName});
}

class CaloriesFoodInListEvent extends NewFoodEvent {
  final String calories;
  CaloriesFoodInListEvent({required this.calories});
}
