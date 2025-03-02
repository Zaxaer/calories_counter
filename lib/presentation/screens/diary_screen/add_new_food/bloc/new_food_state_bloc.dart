class NewFoodState {
  final String foodName;
  final String calories;
  final String protein;
  final String sugar;
  final String fat;
  final bool errorMassege;
  NewFoodState({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.sugar,
    required this.fat,
    required this.errorMassege,
  });

  const NewFoodState.initialState()
    : foodName = '',
      calories = '',
      protein = '',
      sugar = '',
      fat = '',
      errorMassege = false;

  NewFoodState copyWith({
    String? foodName,
    String? calories,
    String? protein,
    String? sugar,
    String? fat,
    bool? errorMassege,
  }) {
    return NewFoodState(
      foodName: foodName ?? this.foodName,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      sugar: sugar ?? this.sugar,
      fat: fat ?? this.fat,
      errorMassege: errorMassege ?? this.errorMassege,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewFoodState &&
        other.foodName == foodName &&
        other.calories == calories &&
        other.protein == protein &&
        other.sugar == sugar &&
        other.fat == fat &&
        other.errorMassege == errorMassege;
  }

  @override
  int get hashCode {
    return foodName.hashCode ^
        calories.hashCode ^
        protein.hashCode ^
        sugar.hashCode ^
        fat.hashCode ^
        errorMassege.hashCode;
  }
}
