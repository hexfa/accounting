import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../entities/customer_order.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class GetOrdersForCustomer extends BaseUseCase<List<CustomerOrder>, String> {
  final OrderRepository repository;

  GetOrdersForCustomer(this.repository);

  @override
  Future<Either<Failure, List<CustomerOrder>>> execute(String customerId) {
    return repository.getOrdersForCustomer(customerId);
  }
}
