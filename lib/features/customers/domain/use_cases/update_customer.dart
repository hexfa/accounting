import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

@lazySingleton
class UpdateCustomer extends BaseUseCase<void, Customer> {
  final CustomerRepository repository;

  UpdateCustomer(this.repository);
  @override
  Future<Either<Failure, void>> execute(Customer customer) {
    return repository.updateCustomer(customer);
  }
}
