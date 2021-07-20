// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'break_down_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreakDownDBAdapter extends TypeAdapter<BreakDownDB> {
  @override
  final int typeId = 3;

  @override
  BreakDownDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BreakDownDB(
      id: fields[0] as String,
      category: fields[1] as String,
      problem: fields[2] as String,
      subproblem: fields[3] as String,
      expectedFare: fields[4] as int,
      v: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BreakDownDB obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.problem)
      ..writeByte(3)
      ..write(obj.subproblem)
      ..writeByte(4)
      ..write(obj.expectedFare)
      ..writeByte(5)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreakDownDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
