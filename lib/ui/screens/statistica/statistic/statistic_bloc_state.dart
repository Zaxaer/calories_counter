import 'package:flutter/foundation.dart';

import 'package:calories_calculator/domine/entity/weight.dart';

class StatisticState {
  final List<WeightStatistic> weight;
  final String weightInput;
  final String perfectWeight;
  final String date;
  final String wantedWeight;
  final bool isGender;
  StatisticState({
    required this.weight,
    required this.weightInput,
    required this.perfectWeight,
    required this.date,
    required this.wantedWeight,
    required this.isGender,
  });

  const StatisticState.initialState()
      : weight = const [],
        weightInput = '1',
        perfectWeight = '',
        date = '',
        wantedWeight = '',
        isGender = false;

  StatisticState copyWith({
    List<WeightStatistic>? weight,
    String? weightInput,
    String? perfectWeight,
    String? date,
    String? wantedWeight,
    bool? isGender,
  }) {
    return StatisticState(
      weight: weight ?? this.weight,
      weightInput: weightInput ?? this.weightInput,
      perfectWeight: perfectWeight ?? this.perfectWeight,
      date: date ?? this.date,
      wantedWeight: wantedWeight ?? this.wantedWeight,
      isGender: isGender ?? this.isGender,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatisticState &&
        listEquals(other.weight, weight) &&
        other.weightInput == weightInput &&
        other.perfectWeight == perfectWeight &&
        other.date == date &&
        other.wantedWeight == wantedWeight &&
        other.isGender == isGender;
  }

  @override
  int get hashCode {
    return weight.hashCode ^
        weightInput.hashCode ^
        perfectWeight.hashCode ^
        date.hashCode ^
        wantedWeight.hashCode ^
        isGender.hashCode;
  }
}
