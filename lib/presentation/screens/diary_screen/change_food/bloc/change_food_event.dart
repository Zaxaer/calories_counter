class ChangeFoodEvent {}

class ReadChangeFoodEvent extends ChangeFoodEvent {}

class AddChangeFoodEvent extends ChangeFoodEvent {}

class ProteinChangeFoodInListEvent extends ChangeFoodEvent {
  final String protein;
  ProteinChangeFoodInListEvent({
    required this.protein,
  });
}

class SugarChangeFoodInListEvent extends ChangeFoodEvent {
  final String sugar;
  SugarChangeFoodInListEvent({
    required this.sugar,
  });
}

class FatChangeFoodInListEvent extends ChangeFoodEvent {
  final String fat;
  FatChangeFoodInListEvent({
    required this.fat,
  });
}

class FoodNameChangeInListEvent extends ChangeFoodEvent {
  final String foodName;
  FoodNameChangeInListEvent({
    required this.foodName,
  });
}

class CaloriesChangeFoodInListEvent extends ChangeFoodEvent {
  final String calories;
  CaloriesChangeFoodInListEvent({
    required this.calories,
  });
}
