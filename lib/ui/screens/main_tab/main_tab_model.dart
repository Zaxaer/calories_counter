import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainTabModel extends ChangeNotifier {
  var _currentTabIndex = 0;
  var topOneLeft = 0.0;
  var topOneRight = 0.0;
  var topTwoLeft = 10.0;
  var topTwoRight = 0.0;
  var topTreeLeft = 0.0;
  var topTreeRight = 0.0;
  var date = '';
  int get currentTabIndex => _currentTabIndex;
  void setCurrentTabIndex(int index) {
    if (index == _currentTabIndex) return;
    _currentTabIndex = index;
    borderRadius(index);
    notifyListeners();
  }

  String stringFromDate() {
    final _dateFormat = DateFormat('EEEE., d MMMM', 'ru');
    date = _dateFormat.format(DateTime.now());
    return date;
  }

  void borderRadius(int index) {
    if (index == 0) {
      topOneLeft = 0.0;
      topOneRight = 0.0;
      topTwoLeft = 10.0;
      topTwoRight = 0.0;
      topTreeLeft = 0.0;
      topTreeRight = 0.0;
    }
    if (index == 1) {
      topOneLeft = 0.0;
      topOneRight = 10.0;
      topTwoLeft = 0.0;
      topTwoRight = 0.0;
      topTreeLeft = 10.0;
      topTreeRight = 0.0;
    }
    if (index == 2) {
      topOneLeft = 0.0;
      topOneRight = 0.0;
      topTwoLeft = 0.0;
      topTwoRight = 10.0;
      topTreeLeft = 0.0;
      topTreeRight = 0.0;
    }
  }
}
