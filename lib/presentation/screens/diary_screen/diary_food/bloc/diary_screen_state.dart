import 'package:calories_calculator/data/entity/food_in_day.dart';
import 'package:flutter/foundation.dart';

class DiaryFoodDayListState {
  final List<FoodInDay> dairyList;
  final String data;
  final String caloriesDay;
  DiaryFoodDayListState({
    required this.dairyList,
    required this.data,
    required this.caloriesDay,
  });

  const DiaryFoodDayListState.initialState()
    : caloriesDay = '',
      data = '',
      dairyList = const [];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiaryFoodDayListState &&
        listEquals(other.dairyList, dairyList) &&
        other.data == data &&
        other.caloriesDay == caloriesDay;
  }

  @override
  int get hashCode => dairyList.hashCode ^ data.hashCode ^ caloriesDay.hashCode;

  DiaryFoodDayListState copyWith({
    List<FoodInDay>? dairyList,
    String? data,
    String? caloriesDay,
  }) {
    return DiaryFoodDayListState(
      dairyList: dairyList ?? this.dairyList,
      data: data ?? this.data,
      caloriesDay: caloriesDay ?? this.caloriesDay,
    );
  }
}
