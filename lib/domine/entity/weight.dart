import 'package:hive_flutter/hive_flutter.dart';

part 'weight.g.dart';

@HiveType(typeId: 3)
class WeightStatistic {
  @HiveField(0)
  double weight;
  @HiveField(1)
  bool isPrefectWeight;
  WeightStatistic({
    required this.weight,
    required this.isPrefectWeight,
  });
}
