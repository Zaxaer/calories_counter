import 'package:flutter/material.dart';

class LearnPerfectWeightModel extends ChangeNotifier {
  var ege = '';
  var hight = '';
  var currentWeight = '';
  var perfectWeight = '';
  final List<bool> isSelected = List.generate(2, (_) => false);

  void genderSelect(int index) {
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex == index) {
        isSelected[buttonIndex] = true;
        notifyListeners();
      } else {
        isSelected[buttonIndex] = false;
        notifyListeners();
      }
    }
  }

  void youPerfectWeight() {
    if (ege.isEmpty || hight.isEmpty) return;
    final egeInt = int.parse(ege);
    final hightInt = int.parse(hight);
    if (isSelected[0] == true) {
      // female
      if (egeInt <= 20) {
        perfectWeight = (hightInt - 100).toString();
        notifyListeners();
      }
      if (egeInt <= 30 || egeInt >= 20) {
        perfectWeight =
            ((hightInt - 100) - ((hightInt - 100) * 0.11)).toString();
        notifyListeners();
      }
      if (egeInt >= 50) {
        perfectWeight =
            ((hightInt - 100) + ((hightInt - 100) * 0.06)).toString();
        notifyListeners();
      }
    }
    if (isSelected[1] == true) {
      // Male
      if (egeInt <= 20) {
        perfectWeight = (hightInt - 110).toString();
        notifyListeners();
      }
      if (egeInt <= 30 || egeInt >= 20) {
        perfectWeight =
            ((hightInt - 110) - ((hightInt - 110) * 0.11)).toString();
        notifyListeners();
      }
      if (egeInt >= 50) {
        perfectWeight =
            ((hightInt - 110) + ((hightInt - 110) * 0.06)).toString();
        notifyListeners();
      }
    }
  }
}
