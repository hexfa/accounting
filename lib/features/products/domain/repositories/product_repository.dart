import 'package:dartz/dartz.dart';
import 'package:accounting/core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, void>> addProduct(Product product);
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, void>> deleteProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product oldProduct, Product updatedProduct);
}
