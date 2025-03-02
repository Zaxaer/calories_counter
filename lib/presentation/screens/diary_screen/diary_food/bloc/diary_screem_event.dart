abstract class FoodEvent {}

class ReadFoodEvent extends FoodEvent {}

class AddFoodDayEvent extends FoodEvent {}

class NextScreenFoodDayEvent extends FoodEvent {}

class DeleteFoodDayEvent extends FoodEvent {
  final int weightIndex;
  DeleteFoodDayEvent({
    required this.weightIndex,
  });
}
