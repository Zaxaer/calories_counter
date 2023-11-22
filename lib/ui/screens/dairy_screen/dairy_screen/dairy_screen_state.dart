import 'package:calories_calculator/domine/entity/food_in_day.dart';
import 'package:flutter/foundation.dart';

class DairyFoodDayListState {
  final List<FoodInDay> dairyList;
  final String data;
  final String caloriesDay;
  DairyFoodDayListState({
    required this.dairyList,
    required this.data,
    required this.caloriesDay,
  });

  const DairyFoodDayListState.initialState()
      : caloriesDay = '',
        data = '',
        dairyList = const [];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DairyFoodDayListState &&
        listEquals(other.dairyList, dairyList) &&
        other.data == data &&
        other.caloriesDay == caloriesDay;
  }

  @override
  int get hashCode => dairyList.hashCode ^ data.hashCode ^ caloriesDay.hashCode;

  DairyFoodDayListState copyWith({
    List<FoodInDay>? dairyList,
    String? data,
    String? caloriesDay,
  }) {
    return DairyFoodDayListState(
      dairyList: dairyList ?? this.dairyList,
      data: data ?? this.data,
      caloriesDay: caloriesDay ?? this.caloriesDay,
    );
  }
}
