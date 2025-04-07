import 'package:dartz/dartz.dart';
import 'package:accounting/core/errors/failures.dart';
import 'package:accounting/core/use_cases/base_use_case.dart';
import 'package:injectable/injectable.dart';
import '../repositories/product_repository.dart';
import '../entities/product.dart';
@lazySingleton
class DeleteProduct extends BaseUseCase<void, Product> {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure, void>> execute(Product product) {
    return repository.deleteProduct(product);
  }
}
