class CurrentWeightEvent {}

class NavigatorPopCurrentWeight extends CurrentWeightEvent {}

class DiffCurrentWeightEvent extends CurrentWeightEvent {}

class SumCurrentWeightEvent extends CurrentWeightEvent {}

class InputCurrentWeightEvent extends CurrentWeightEvent {
  final String weight;
  InputCurrentWeightEvent({required this.weight});
}
