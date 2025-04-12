// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 1;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel(
      hiveId: fields[0] as String,
      hiveFirstName: fields[1] as String,
      hiveLastName: fields[2] as String,
      hiveAddress: fields[3] as String,
      hivePostalCode: fields[4] as String,
      hivePhone: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hiveId)
      ..writeByte(1)
      ..write(obj.hiveFirstName)
      ..writeByte(2)
      ..write(obj.hiveLastName)
      ..writeByte(3)
      ..write(obj.hiveAddress)
      ..writeByte(4)
      ..write(obj.hivePostalCode)
      ..writeByte(5)
      ..write(obj.hivePhone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
