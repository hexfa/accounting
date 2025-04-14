import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

@lazySingleton
class AddCustomer extends BaseUseCase<void, Customer> {
  final CustomerRepository repository;

  AddCustomer(this.repository);

  @override
  Future<Either<Failure, void>> execute(Customer params) async {
    return repository.addCustomer(params);
}
