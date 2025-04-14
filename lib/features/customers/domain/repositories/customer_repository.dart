import 'package:dartz/dartz.dart';
import 'package:accounting/core/errors/failures.dart';
import '../entities/customer.dart';

abstract class CustomerRepository {
  Future<Either<Failure, void>> addCustomer(Customer customer);
  Future<Either<Failure, void>> updateCustomer(Customer customer);
  Future<Either<Failure, void>> deleteCustomer(String id);
  Future<Either<Failure, List<Customer>>> getAllCustomers();
  Future<Either<Failure, Customer?>> getCustomerById(String id);
}
