import 'package:hive/hive.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends Product with HiveObjectMixin {
  @HiveField(0)
  final String hiveName;

  @HiveField(1)
  final String hiveCode;

  @HiveField(2)
  final int hiveQuantity;

  @HiveField(3)
  final double hiveWholesalePrice;

  @HiveField(4)
  final double hiveRetailPrice;

  ProductModel({
    required this.hiveName,
    required this.hiveCode,
    required this.hiveQuantity,
    required this.hiveWholesalePrice,
    required this.hiveRetailPrice,
  }) : super(
    name: hiveName,
    code: hiveCode,
    quantity: hiveQuantity,
    wholesalePrice: hiveWholesalePrice,
    retailPrice: hiveRetailPrice,
  );

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      hiveName: product.name,
      hiveCode: product.code,
      hiveQuantity: product.quantity,
      hiveWholesalePrice: product.wholesalePrice,
      hiveRetailPrice: product.retailPrice,
    );
  }

  Product toEntity() {
    return Product(
      name: hiveName,
      code: hiveCode,
      quantity: hiveQuantity,
      wholesalePrice: hiveWholesalePrice,
      retailPrice: hiveRetailPrice,
    );
  }
}
