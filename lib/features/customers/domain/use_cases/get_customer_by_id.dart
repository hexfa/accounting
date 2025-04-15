import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

@lazySingleton
class GetCustomerById extends BaseUseCase<Customer?, String> {
  final CustomerRepository repository;

  GetCustomerById(this.repository);

  @override
  Future<Either<Failure, Customer?>> execute(String id) {
    return repository.getCustomerById(id);
  }
}