// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_in_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodInDayAdapter extends TypeAdapter<FoodInDay> {
  @override
  final int typeId = 5;

  @override
  FoodInDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodInDay(
      caloriesInDay: fields[0] as int,
      foodName: fields[1] as String,
      caloriesDay: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FoodInDay obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.caloriesInDay)
      ..writeByte(1)
      ..write(obj.foodName)
      ..writeByte(2)
      ..write(obj.caloriesDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodInDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
