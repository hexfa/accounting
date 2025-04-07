import 'package:hive/hive.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends Product {
  @HiveField(0)
  final String hiveName;

  @HiveField(1)
  final String hiveCode;


  @HiveField(2)
  final double hivePrice;

  ProductModel({
    required this.hiveName,
    required this.hiveCode,
    required this.hivePrice,
  }) : super(name: hiveName, code: hiveCode, price: hivePrice);

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      hiveName: product.name,
      hiveCode: product.code,
      hivePrice: product.price,
    );
  }

  Product toEntity() {
    return Product(name: hiveName, code: hiveCode, price: hivePrice);
  }
}
