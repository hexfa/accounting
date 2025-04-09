// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      hiveName: fields[0] as String,
      hiveCode: fields[1] as String,
      hiveQuantity: fields[2] as int,
      hiveWholesalePrice: fields[3] as double,
      hiveRetailPrice: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.hiveName)
      ..writeByte(1)
      ..write(obj.hiveCode)
      ..writeByte(2)
      ..write(obj.hiveQuantity)
      ..writeByte(3)
      ..write(obj.hiveWholesalePrice)
      ..writeByte(4)
      ..write(obj.hiveRetailPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
