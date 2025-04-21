import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../entities/customer_order.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class AddOrder extends BaseUseCase<void, CustomerOrder> {
  final OrderRepository repository;

  AddOrder(this.repository);

  @override
  Future<Either<Failure, void>> execute(CustomerOrder order) {
    return repository.addOrder(order);
  }
}
