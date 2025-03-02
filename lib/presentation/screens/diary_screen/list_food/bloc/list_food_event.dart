class FoodListEvent {}

class ReadFoodListEvent extends FoodListEvent {}

class ChangeFoodEvent extends FoodListEvent {
  final int index;
  ChangeFoodEvent({
    required this.index,
  });
}

class DeleteFoodEvent extends FoodListEvent {
  final int index;
  DeleteFoodEvent({
    required this.index,
  });
}

class AddNewFoodEvent extends FoodListEvent {}

class ExpansionTileEvent extends FoodListEvent {}

class DiffPorciesEvent extends FoodListEvent {
  final int index;
  DiffPorciesEvent({
    required this.index,
  });
}

class SumPorciesEvent extends FoodListEvent {
  final int index;
  SumPorciesEvent({
    required this.index,
  });
}

class SelectTableFoodListEvent extends FoodListEvent {
  final int index;
  final String foodName;
  final double caloriesDayFood;
  SelectTableFoodListEvent({
    required this.index,
    required this.foodName,
    required this.caloriesDayFood,
  });
}

class AddDayFoodListEvent extends FoodListEvent {}

class SearchFoodListEvent extends FoodListEvent {
  final String enteredKeyword;
  SearchFoodListEvent({
    required this.enteredKeyword,
  });

  SearchFoodListEvent copyWith({
    String? enteredKeyword,
  }) {
    return SearchFoodListEvent(
      enteredKeyword: enteredKeyword ?? this.enteredKeyword,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchFoodListEvent &&
        other.enteredKeyword == enteredKeyword;
  }

  @override
  int get hashCode => enteredKeyword.hashCode;
}
