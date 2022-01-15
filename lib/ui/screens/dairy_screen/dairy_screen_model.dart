import 'package:calorie_calculator_exemple/domine/entity/food_in_day.dart';
import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DairyScreenModel extends ChangeNotifier {
  var date = '';
  var _foodInDay = <FoodInDay>[];
  String caloriesOnDay = '0';
  List<FoodInDay> get foodInDay => _foodInDay.toList();
  String stringFromDate() {
    final _dateFormat = DateFormat('EEEE., d MMMM', 'ru');
    date = _dateFormat.format(DateTime.now());
    return date;
  }

  DairyScreenModel() {
    _setup();
  }

  void deleteGroup(int weightIndex) async {
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(FoodInDayAdapter());
    }
    final box = await Hive.openBox<FoodInDay>('foodDay_box');
    await box.deleteAt(weightIndex);
  }

  void _readGroupsFromHive(Box<FoodInDay> box) async {
    _foodInDay = box.values.toList();
    _caloriesDay();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(FoodInDayAdapter());
    }
    final box = await Hive.openBox<FoodInDay>('foodDay_box');
    // box.clear();
    _readGroupsFromHive(box);
    box.listenable().addListener(() => _readGroupsFromHive(box));
  }

  void _caloriesDay() {
    if (_foodInDay.isEmpty) {
      caloriesOnDay = '0';
      notifyListeners();
      return;
    } else {
      final calDay = _foodInDay.map((e) => e.caloriesInDay * e.caloriesDay);
      final result = calDay.reduce((value, element) => value + element).toInt();
      caloriesOnDay = result.toString();
      notifyListeners();
    }
  }

  void snackBar(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 1.333,
      fontFamily: AppFonts.ubuntu,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color(0xFF333333),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 14, left: 8, right: 8),
      padding: const EdgeInsets.only(top: 12, left: 20, right: 14, bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Row(
        children: [
          Image.asset(AppImages.trash),
          const SizedBox(width: 14),
          const Expanded(child: Text('Delited', style: style)),
          SizedBox(
            height: 24,
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: const Text(
                'Cansel',
                style: style,
              ),
            ),
          ),
        ],
      ),
    ));
    notifyListeners();
  }
}
