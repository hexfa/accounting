import 'package:dartz/dartz.dart';
import 'package:accounting/core/errors/failures.dart';
import 'package:accounting/core/use_cases/base_use_case.dart';
import 'package:injectable/injectable.dart';
import '../repositories/product_repository.dart';
import '../entities/product.dart';

@lazySingleton
class UpdateProduct extends BaseUseCase<void, UpdateProductParams> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, void>> execute(UpdateProductParams params) {
    return repository.updateProduct(params.oldProduct, params.updatedProduct);
  }
}
class UpdateProductParams {
  final Product oldProduct;
  final Product updatedProduct;

  UpdateProductParams({
    required this.oldProduct,
    required this.updatedProduct,
  });
}