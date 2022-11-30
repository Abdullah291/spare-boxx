// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MobileStorageAdapter extends TypeAdapter<MobileStorage> {
  @override
  final int typeId = 1;

  @override
  MobileStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MobileStorage(
      token: fields[0] as String?,
      expireDate: fields[1] as DateTime?,
      id: fields[2] as int?,
      name: fields[3] as String?,
      email: fields[4] as String?,
      phoneNo: fields[5] as String?,
      countryId: fields[6] as String?,
      avatar: fields[7] as String?,
      type: fields[8] as String?,
      userType: fields[9] as String?,
      isVerified: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MobileStorage obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.expireDate)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phoneNo)
      ..writeByte(6)
      ..write(obj.countryId)
      ..writeByte(7)
      ..write(obj.avatar)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.userType)
      ..writeByte(10)
      ..write(obj.isVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MobileStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
