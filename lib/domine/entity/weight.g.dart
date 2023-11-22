// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightStatisticAdapter extends TypeAdapter<WeightStatistic> {
  @override
  final int typeId = 3;

  @override
  WeightStatistic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightStatistic(
      weight: fields[0] as double,
      isPrefectWeight: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WeightStatistic obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.weight)
      ..writeByte(1)
      ..write(obj.isPrefectWeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightStatisticAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
