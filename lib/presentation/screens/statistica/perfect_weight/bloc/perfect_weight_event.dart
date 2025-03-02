class PerfectWeightEvent {}

class InputAgeLearnPerfectWeightEvent extends PerfectWeightEvent {
  final String textInput;
  InputAgeLearnPerfectWeightEvent({required this.textInput});
}

class InputGrowthLearnPerfectWeightEvent extends PerfectWeightEvent {
  final String textInput;
  InputGrowthLearnPerfectWeightEvent({required this.textInput});
}

class GenderSelectLearnPerfectWeightEvent extends PerfectWeightEvent {
  final int indexGender;
  GenderSelectLearnPerfectWeightEvent({required this.indexGender});
}

class ResultLearnPerfectWeightEvent extends PerfectWeightEvent {}

class NavigatopPopLearnPerfectWeightEvent extends PerfectWeightEvent {}

class NavigatopInfoLearnPerfectWeightEvent extends PerfectWeightEvent {}
