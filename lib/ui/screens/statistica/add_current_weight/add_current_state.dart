class AddCurrentWeightState {
  final String weightText;
  AddCurrentWeightState({
    required this.weightText,
  });

  const AddCurrentWeightState.initialState() : weightText = '1';

  AddCurrentWeightState copyWith({
    String? weightText,
  }) {
    return AddCurrentWeightState(
      weightText: weightText ?? this.weightText,
    );
  }

  @override
  String toString() => 'AddCurrentWeightState(weightText: $weightText)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddCurrentWeightState && other.weightText == weightText;
  }

  @override
  int get hashCode => weightText.hashCode;
}
