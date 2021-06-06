// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cutomer_owned_cars_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class customerOwnedCarsDBAdapter extends TypeAdapter<customerOwnedCarsDB> {
  @override
  final int typeId = 0;

  @override
  customerOwnedCarsDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return customerOwnedCarsDB(
      id: fields[0] as String,
      CarBrand: fields[1] as String,
      Model: fields[2] as String,
      Year: fields[3] as String,
      OwnerId: fields[4] as String,
      Plates: fields[5] as String,
      v: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, customerOwnedCarsDB obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.CarBrand)
      ..writeByte(2)
      ..write(obj.Model)
      ..writeByte(3)
      ..write(obj.Year)
      ..writeByte(4)
      ..write(obj.OwnerId)
      ..writeByte(5)
      ..write(obj.Plates)
      ..writeByte(6)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is customerOwnedCarsDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
