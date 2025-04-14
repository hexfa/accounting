import 'package:accounting/features/customers/data/data_sources/customer_local_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';

@LazySingleton(as: CustomerRepository)
class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerLocalDatasource datasource;

  CustomerRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, void>> addCustomer(Customer customer) async {
    try {
      await datasource.addCustomer(customer);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('خطا در افزودن مشتری: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCustomer(Customer customer) async {
    try {
      await datasource.updateCustomer(customer);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('خطا در بروزرسانی مشتری: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCustomer(String id) async {
    try {
      await datasource.deleteCustomer(id);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('خطا در حذف مشتری: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Customer>>> getAllCustomers() async {
    try {
      final customers = await datasource.getAllCustomers();
      return Right(customers);
    } catch (e) {
      return Left(UnknownFailure('خطا در دریافت لیست مشتری‌ها: $e'));
    }
  }

  @override
  Future<Either<Failure, Customer?>> getCustomerById(String id) async {
    try {
      final customer = await datasource.getCustomerById(id);
      return Right(customer);
    } catch (e) {
      return Left(UnknownFailure('خطا در دریافت مشتری: $e'));
    }
  }
}
