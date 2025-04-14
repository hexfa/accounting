import 'package:accounting/core/errors/failures.dart';
import 'package:accounting/core/use_cases/base_use_case_no_params.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

@lazySingleton
class GetAllCustomers extends BaseUseCaseNoParams<List<Customer>> {
  final CustomerRepository repository;

  GetAllCustomers(this.repository);

  @override
  Future<Either<Failure, List<Customer>>> execute() {
    return repository.getAllCustomers();
  }


}
