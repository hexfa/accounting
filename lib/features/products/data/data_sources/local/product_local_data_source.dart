import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:hive/hive.dart';
import 'package:accounting/features/products/data/models/product_model.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: ProductLocalDatasource)
class HiveProductLocalDatasource implements ProductLocalDatasource {
  static const String boxName = 'products';

  Future<Box<ProductModel>> _openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<ProductModel>(boxName);
    }
    return Hive.box<ProductModel>(boxName);
  }

  @override
  Future<void> addProduct(Product product) async {
    final box = await _openBox();
    final productModel = ProductModel.fromEntity(product);
    await box.add(productModel);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final box = await _openBox();
    return box.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> deleteProduct(Product product) async {
    final box = await _openBox();
    final index = box.values.toList().indexWhere((e) => e.code == product.code);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  @override
  Future<void> updateProduct(Product oldProduct, Product updatedProduct) async {
    final box = await _openBox();
    final index = box.values.toList().indexWhere((e) => e.code == oldProduct.code);
    if (index != -1) {
      final updatedModel = ProductModel.fromEntity(updatedProduct);
      await box.putAt(index, updatedModel);
    }
  }
}

abstract class ProductLocalDatasource {
  Future<void> addProduct(Product product);
  Future<List<Product>> getAllProducts();
  Future<void> deleteProduct(Product product);
  Future<void> updateProduct(Product oldProduct, Product updatedProduct);
}
