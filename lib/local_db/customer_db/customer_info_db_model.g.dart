// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_info_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class customerInfoDBAdapter extends TypeAdapter<customerInfoDB> {
  @override
  final int typeId = 1;

  @override
  customerInfoDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return customerInfoDB(
      CURRENT_LANGUAGE: fields[0] as String,
      JWT_TOKEN: fields[1] as String,
      FIREBASE_ID: fields[2] as String,
      BACKEND_ID: fields[3] as String,
      FIRST_NAME: fields[4] as String,
      LAST_NAME: fields[5] as String,
      PHONE_NUMBER: fields[6] as String,
      IAT: fields[7] as String,
      SOCIAL_IMAGE: fields[8] as String,
      SOCIAL_EMAIL: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, customerInfoDB obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.CURRENT_LANGUAGE)
      ..writeByte(1)
      ..write(obj.JWT_TOKEN)
      ..writeByte(2)
      ..write(obj.FIREBASE_ID)
      ..writeByte(3)
      ..write(obj.BACKEND_ID)
      ..writeByte(4)
      ..write(obj.FIRST_NAME)
      ..writeByte(5)
      ..write(obj.LAST_NAME)
      ..writeByte(6)
      ..write(obj.PHONE_NUMBER)
      ..writeByte(7)
      ..write(obj.IAT)
      ..writeByte(8)
      ..write(obj.SOCIAL_IMAGE)
      ..writeByte(9)
      ..write(obj.SOCIAL_EMAIL);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is customerInfoDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
