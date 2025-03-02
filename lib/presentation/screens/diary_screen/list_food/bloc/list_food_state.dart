import 'package:flutter/foundation.dart';

import 'package:calories_calculator/data/entity/food_data.dart';

class FoodListState {
  final List<FoodData> listFood;
  final int selectedIndex;
  final int selectedIndexSum;
  final String foodName;
  final double caloriesFood;
  final int porcionIndex;
  final int indexPorcies;
  final bool isExpanded;
  FoodListState({
    required this.listFood,
    required this.selectedIndex,
    required this.selectedIndexSum,
    required this.foodName,
    required this.caloriesFood,
    required this.porcionIndex,
    required this.indexPorcies,
    required this.isExpanded,
  });

  const FoodListState.initialState()
    : selectedIndexSum = -1,
      selectedIndex = -1,
      foodName = '',
      caloriesFood = 0,
      porcionIndex = 0,
      isExpanded = true,
      indexPorcies = 1,
      listFood = const [];

  FoodListState copyWith({
    List<FoodData>? listFood,
    int? selectedIndex,
    int? selectedIndexSum,
    String? foodName,
    double? caloriesFood,
    int? porcionIndex,
    int? indexPorcies,
    bool? isExpanded,
  }) {
    return FoodListState(
      listFood: listFood ?? this.listFood,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedIndexSum: selectedIndexSum ?? this.selectedIndexSum,
      foodName: foodName ?? this.foodName,
      caloriesFood: caloriesFood ?? this.caloriesFood,
      porcionIndex: porcionIndex ?? this.porcionIndex,
      indexPorcies: indexPorcies ?? this.indexPorcies,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodListState &&
        listEquals(other.listFood, listFood) &&
        other.selectedIndex == selectedIndex &&
        other.selectedIndexSum == selectedIndexSum &&
        other.foodName == foodName &&
        other.caloriesFood == caloriesFood &&
        other.porcionIndex == porcionIndex &&
        other.indexPorcies == indexPorcies &&
        other.isExpanded == isExpanded;
  }

  @override
  int get hashCode {
    return listFood.hashCode ^
        selectedIndex.hashCode ^
        selectedIndexSum.hashCode ^
        foodName.hashCode ^
        caloriesFood.hashCode ^
        porcionIndex.hashCode ^
        indexPorcies.hashCode ^
        isExpanded.hashCode;
  }
}
