import 'package:accounting/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../repositories/customer_repository.dart';

@lazySingleton
class DeleteCustomer extends BaseUseCase<void, String> {
  final CustomerRepository repository;

  DeleteCustomer(this.repository);

  @override
  Future<Either<Failure, void>> execute(String params) {
   return repository.deleteCustomer(params);
  }

}
