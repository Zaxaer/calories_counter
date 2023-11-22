class AddCurrentWeightEvent {}

class NavigatorPopCurrentWeight extends AddCurrentWeightEvent {}

class DiffCurrentWeightEvent extends AddCurrentWeightEvent {}

class SumCurrentWeightEvent extends AddCurrentWeightEvent {}

class InputCurrentWeightEvent extends AddCurrentWeightEvent {
  final String weight;
  InputCurrentWeightEvent({
    required this.weight,
  });
}
