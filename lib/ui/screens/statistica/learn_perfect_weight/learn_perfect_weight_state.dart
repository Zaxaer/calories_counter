import 'package:flutter/foundation.dart';

class LearnPerfectWeightState {
  final String ege;
  final String hight;
  final String currentWeight;
  final String perfectWeight;
  final List<bool> isSelected;
  LearnPerfectWeightState({
    required this.ege,
    required this.hight,
    required this.currentWeight,
    required this.perfectWeight,
    required this.isSelected,
  });

  LearnPerfectWeightState.initialState()
      : ege = '',
        hight = '',
        currentWeight = '',
        perfectWeight = '',
        isSelected = List.generate(2, (_) => false);

  LearnPerfectWeightState copyWith({
    String? ege,
    String? hight,
    String? currentWeight,
    String? perfectWeight,
    List<bool>? isSelected,
  }) {
    return LearnPerfectWeightState(
      ege: ege ?? this.ege,
      hight: hight ?? this.hight,
      currentWeight: currentWeight ?? this.currentWeight,
      perfectWeight: perfectWeight ?? this.perfectWeight,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LearnPerfectWeightState &&
        other.ege == ege &&
        other.hight == hight &&
        other.currentWeight == currentWeight &&
        other.perfectWeight == perfectWeight &&
        listEquals(other.isSelected, isSelected);
  }

  @override
  int get hashCode {
    return ege.hashCode ^
        hight.hashCode ^
        currentWeight.hashCode ^
        perfectWeight.hashCode ^
        isSelected.hashCode;
  }
}
