// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodDataAdapter extends TypeAdapter<FoodData> {
  @override
  final int typeId = 4;

  @override
  FoodData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodData(
      foodName: fields[0] as String,
      calories: fields[1] as double,
      proteint: fields[2] as String,
      sugar: fields[3] as String,
      fat: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FoodData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.foodName)
      ..writeByte(1)
      ..write(obj.calories)
      ..writeByte(2)
      ..write(obj.proteint)
      ..writeByte(3)
      ..write(obj.sugar)
      ..writeByte(4)
      ..write(obj.fat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
