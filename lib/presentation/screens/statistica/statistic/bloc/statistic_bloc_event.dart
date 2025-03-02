class StatisticEvent {}

class ReadStatisticEvent extends StatisticEvent {}

class NavigatorAddCurrentWeightStatisticEvent extends StatisticEvent {}

class LearnPerfectWeightStatisticEvent extends StatisticEvent {}

class WeightInputStatisticEvent extends StatisticEvent {
  final String weight;
  WeightInputStatisticEvent({required this.weight});
}

class DeleteWeightStatisticEvent extends StatisticEvent {
  final int index;
  DeleteWeightStatisticEvent({required this.index});
}

class SaveWeightStatisticEvent extends StatisticEvent {}
