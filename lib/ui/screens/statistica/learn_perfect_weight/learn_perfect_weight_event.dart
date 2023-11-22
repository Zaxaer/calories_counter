class LearnPerfectWeightEvent {}

class InputAgeLearnPerfectWeightEvent extends LearnPerfectWeightEvent {
  final String textInput;
  InputAgeLearnPerfectWeightEvent({
    required this.textInput,
  });
}

class InputGrowthLearnPerfectWeightEvent extends LearnPerfectWeightEvent {
  final String textInput;
  InputGrowthLearnPerfectWeightEvent({
    required this.textInput,
  });
}

class GenderSelectLearnPerfectWeightEvent extends LearnPerfectWeightEvent {
  final int indexGender;
  GenderSelectLearnPerfectWeightEvent({
    required this.indexGender,
  });
}

class ResultLearnPerfectWeightEvent extends LearnPerfectWeightEvent {}

class NavigatopPopLearnPerfectWeightEvent extends LearnPerfectWeightEvent {}

class NavigatopInfoLearnPerfectWeightEvent extends LearnPerfectWeightEvent {}
