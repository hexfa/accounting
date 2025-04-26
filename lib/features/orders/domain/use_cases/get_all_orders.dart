import 'package:accounting/core/use_cases/base_use_case_no_params.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/customer_order.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class GetAllOrders extends BaseUseCaseNoParams<List<CustomerOrder>> {
  final OrderRepository repository;

  GetAllOrders(this.repository);

  @override
  Future<Either<Failure, List<CustomerOrder>>> execute() {
    return repository.getAllOrders();
  }
}
