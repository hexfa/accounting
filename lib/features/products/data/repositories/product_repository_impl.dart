import 'package:accounting/features/products/data/data_sources/local/product_local_data_source.dart';
import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:accounting/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:accounting/core/errors/failures.dart';
import 'package:accounting/core/errors/exception_handler.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final ProductLocalDatasource localDatasource;

  ProductRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, void>> addProduct(Product product) async {
    try {
      await localDatasource.addProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e));
    }
  }



  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await localDatasource.getAllProducts();
      return Right(products);
    } catch (e) {
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(Product product) async {
    try {
      await localDatasource.deleteProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product oldProduct, Product updatedProduct) async {
    try {
      await localDatasource.updateProduct(oldProduct, updatedProduct);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e));
    }
  }
}
