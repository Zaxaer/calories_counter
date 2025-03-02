import 'package:calories_calculator/data/entity/weight.dart';
import 'package:calories_calculator/data/repository/hive_repository.dart';
import 'package:calories_calculator/presentation/screens/statistica/statistic/bloc/statistic_bloc_state.dart';

abstract class StatisticaRepo extends HiveRepositoryStorage {
  Future<List<WeightStatistic>> createStatisticBox();

  Future<void> deleteStatisticBox(int index, StatisticState state);

  Future<void> saveWeightBox(StatisticState state, String weightInput);

  Future<void> updatePerfectWeightStatisticBox(StatisticState state);
}
