import 'package:calorie_calculator_exemple/domine/entity/weight.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_model.dart';
import 'package:calorie_calculator_exemple/ui/screens/statistica/learn_perfect_weight/learn_perfect_weight_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class StatisticModel extends ChangeNotifier {
  var _weight = <WeightStatistic>[];
  List<WeightStatistic> get weight => _weight.toList();
  var weightInput = '1';
  var perfectWeight = '';
  var date = '';
  String awesome = '';
  String wantedWeight = '';
  final bool isGender = false;
  bool isAddButton = false;

  StatisticModel() {
    _setup();
  }

  void deleteGroup(int weightIndex) async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>('Statistic_box');
    if (weight.last.isPrefectWeight == true &&
        weight.length == 2 &&
        weightIndex == 0) {
      box.clear();
    } else {
      await box.deleteAt(weightIndex);
    }
  }

  void addPerfectWeight(BuildContext context) async {
    final result = await Navigator.push<String>(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => LearnPerfectWeightModel(),
                  child: const LearnPerfectWeightWidget())),
        ) ??
        '';
    perfectWeight = result;
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    if (perfectWeight == '') return;
    final box = await Hive.openBox<WeightStatistic>('Statistic_box');
    final perfectWeightInt = WeightStatistic(
        weight: double.parse(perfectWeight), isPrefectWeight: true);

    await box.add(perfectWeightInt);
  }

  void _readGroupsFromHive(Box<WeightStatistic> box) async {
    _weight = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>('Statistic_box');
    // box.clear();
    _readGroupsFromHive(box);
    box.listenable().addListener(() => _readGroupsFromHive(box));
  }

  void awesomeText(int index) {
    awesome = '';
    isAddButton = false;
    if (index == 0) {
      if (_weight.last.isPrefectWeight == true &&
          _weight.reversed.elementAt(1) == _weight[index]) {
        isAddButton = true;
      }
    }
    if (index >= 1) {
      if (_weight.last.isPrefectWeight == false &&
          _weight.last == _weight[index]) {
        if (_weight.last.weight < _weight.reversed.elementAt(1).weight) {
          awesome = 'Awesome';
        }
        isAddButton = true;
      } else if (_weight.last.isPrefectWeight == true &&
          _weight.reversed.elementAt(1) == _weight[index]) {
        if (_weight.reversed.elementAt(1).weight <
            _weight.reversed.elementAt(2).weight) {
          awesome = 'Awesome';
        }
        isAddButton = true;
      }
      if (_weight.last.isPrefectWeight == true &&
          _weight.last == _weight[index]) {
        wantedWeight = ' kg wanted weight';
      }
    }
  }

  void sum() {
    final intWeight = int.parse(weightInput);
    if (intWeight >= 1) {
      weightInput = (int.parse(weightInput) + 1).toString();
      notifyListeners();
    }
  }

  void diff() {
    final intWeight = int.parse(weightInput);
    if (intWeight > 1) {
      weightInput = (intWeight - 1).toString();
      notifyListeners();
    } else if (intWeight == 1) {
      return;
    }
  }

  void saveWeight(BuildContext context) async {
    if (weightInput == '1' || weightInput == '') return;
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>('Statistic_box');
    if (weight.isEmpty) {
      final weightInt = WeightStatistic(
          weight: double.parse(weightInput), isPrefectWeight: false);
      await box.add(weightInt);
    } else if (weight.last.isPrefectWeight == false) {
      final weightInt = WeightStatistic(
          weight: double.parse(weightInput), isPrefectWeight: false);
      await box.add(weightInt);
    } else if (weight.last.isPrefectWeight == true) {
      final lastElement = box.values.last;
      final lastKey = box.keys.last as int;
      box.delete(lastKey);
      final weightInt = WeightStatistic(
          weight: double.parse(weightInput), isPrefectWeight: false);
      await box.add(weightInt);
      await box.add(lastElement);
    }
    Navigator.of(context).pop();
  }
}
