import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class DeleteOrder extends BaseUseCase<void, String> {
  final OrderRepository repository;

  DeleteOrder(this.repository);

  @override
  Future<Either<Failure, void>> execute(String orderId) {
    return repository.deleteOrder(orderId);
  }
}
