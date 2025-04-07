import 'package:accounting/core/use_cases/base_use_case_no_params.dart';
import 'package:dartz/dartz.dart';
import 'package:accounting/core/errors/failures.dart';
import '../repositories/product_repository.dart';
import '../entities/product.dart';

class GetAllProducts extends BaseUseCaseNoParams<List<Product>> {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> execute() {
    return repository.getAllProducts();
  }
}
