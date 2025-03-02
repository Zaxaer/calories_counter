class CurrentWeightState {
  final String weightText;
  CurrentWeightState({required this.weightText});

  const CurrentWeightState.initialState() : weightText = '1';

  CurrentWeightState copyWith({String? weightText}) {
    return CurrentWeightState(weightText: weightText ?? this.weightText);
  }

  @override
  String toString() => 'AddCurrentWeightState(weightText: $weightText)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrentWeightState && other.weightText == weightText;
  }

  @override
  int get hashCode => weightText.hashCode;
}
