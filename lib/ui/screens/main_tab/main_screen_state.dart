import 'package:intl/intl.dart';

class MainScreenState {
  final int currentTabIndex;
  final String data;
  MainScreenState({
    required this.currentTabIndex,
    required this.data,
  });

  MainScreenState.initialState()
      : currentTabIndex = 0,
        data = stringFromDate();

  static String stringFromDate() {
    final dateFormat = DateFormat('EEEE., d MMMM', 'ru');
    final date = dateFormat.format(DateTime.now());
    return date;
  }

  MainScreenState copyWith({
    int? currentTabIndex,
    String? data,
  }) {
    return MainScreenState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainScreenState &&
        other.currentTabIndex == currentTabIndex &&
        other.data == data;
  }

  @override
  int get hashCode => currentTabIndex.hashCode ^ data.hashCode;
}
