// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 2;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      hiveId: fields[0] as String,
      hiveCustomerId: fields[1] as String,
      hiveProductCode: fields[2] as String,
      hiveUnitPrice: fields[3] as double,
      hiveQuantity: fields[4] as int,
      hiveDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hiveId)
      ..writeByte(1)
      ..write(obj.hiveCustomerId)
      ..writeByte(2)
      ..write(obj.hiveProductCode)
      ..writeByte(3)
      ..write(obj.hiveUnitPrice)
      ..writeByte(4)
      ..write(obj.hiveQuantity)
      ..writeByte(5)
      ..write(obj.hiveDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
