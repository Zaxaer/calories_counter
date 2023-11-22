class AddNewFoodEvent {}

class AddNewFoodInListEvent extends AddNewFoodEvent {}

class ProteinFoodInListEvent extends AddNewFoodEvent {
  final String protein;
  ProteinFoodInListEvent({
    required this.protein,
  });
}

class SugarFoodInListEvent extends AddNewFoodEvent {
  final String sugar;
  SugarFoodInListEvent({
    required this.sugar,
  });
}

class FatFoodInListEvent extends AddNewFoodEvent {
  final String fat;
  FatFoodInListEvent({
    required this.fat,
  });
}

class FoodNameInListEvent extends AddNewFoodEvent {
  final String foodName;
  FoodNameInListEvent({
    required this.foodName,
  });
}

class CaloriesFoodInListEvent extends AddNewFoodEvent {
  final String calories;
  CaloriesFoodInListEvent({
    required this.calories,
  });
}
