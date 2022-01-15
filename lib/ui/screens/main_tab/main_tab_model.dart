import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainTabModel extends ChangeNotifier {
  var _currentTabIndex = 0;

  var date = '';
  int get currentTabIndex => _currentTabIndex;
  void setCurrentTabIndex(int index) {
    if (index == _currentTabIndex) return;
    _currentTabIndex = index;
    notifyListeners();
  }

  String stringFromDate() {
    final _dateFormat = DateFormat('EEEE., d MMMM', 'ru');
    date = _dateFormat.format(DateTime.now());
    return date;
  }
}
