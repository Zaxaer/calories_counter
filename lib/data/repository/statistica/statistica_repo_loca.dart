import 'package:calories_calculator/data/entity/weight.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';
import 'package:calories_calculator/data/repository/statistica/statistica_repo.dart';
import 'package:calories_calculator/presentation/screens/statistica/statistic/bloc/statistic_bloc_state.dart';
import 'package:calories_calculator/resources/configuration.dart';
import 'package:hive/hive.dart';

class StatisticaRepoLoca extends HiveRepositoryStorage
    implements StatisticaRepo {
  @override
  Future<List<WeightStatistic>> createStatisticBox() async {
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);
    final statisticList = box.values.toList();
    return statisticList;
  }

  @override
  Future<void> deleteStatisticBox(int index, StatisticState state) async {
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);
    if (state.weight.last.isPrefectWeight == true &&
        state.weight.length == 2 &&
        index == 0) {
      box.clear();
    } else {
      await box.deleteAt(index);
    }
  }

  @override
  Future<void> saveWeightBox(StatisticState state, String weightInput) async {
    if (weightInput == '1' || weightInput == '') return;
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);
    if (state.weight.isEmpty) {
      final weightInt = WeightStatistic(
        weight: double.parse(weightInput),
        isPrefectWeight: false,
      );
      await box.add(weightInt);
    } else if (state.weight.last.isPrefectWeight == false) {
      final weightInt = WeightStatistic(
        weight: double.parse(weightInput),
        isPrefectWeight: false,
      );
      await box.add(weightInt);
    } else if (state.weight.last.isPrefectWeight == true) {
      final lastElement = box.values.last;
      final lastKey = box.keys.last as int;
      box.delete(lastKey);
      final weightInt = WeightStatistic(
        weight: double.parse(weightInput),
        isPrefectWeight: false,
      );
      await box.add(weightInt);
      await box.add(lastElement);
    }
  }

  @override
  Future<void> updatePerfectWeightStatisticBox(StatisticState state) async {
    if (!Hive.isAdapterRegistered(Configuration.statistocIdBox)) {
      Hive.registerAdapter(WeightStatisticAdapter());
    }
    if (state.perfectWeight == '') return;
    final box = await Hive.openBox<WeightStatistic>(Configuration.statisticBox);

    final perfectWeightInt = WeightStatistic(
      weight: double.parse(state.perfectWeight),
      isPrefectWeight: true,
    );
    await box.add(perfectWeightInt);
  }
}
