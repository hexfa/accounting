

import 'package:accounting/core/errors/failures.dart';
import 'package:accounting/core/use_cases/base_use_case.dart';
import 'package:accounting/features/customers/domain/entities/customer.dart';
import 'package:accounting/features/customers/domain/repositories/customer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class AddCustomer extends BaseUseCase<void, Customer> {
  final CustomerRepository repository;
  AddCustomer(this.repository);
  @override
  Future<Either<Failure, void>> execute(Customer params) async {
    return repository.addCustomer(params);
  }

}

