import 'package:injectable/injectable.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_local_datasource.dart';

@LazySingleton(as: CustomerRepository)
class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerLocalDatasource datasource;

  CustomerRepositoryImpl(this.datasource);

  @override
  Future<void> addCustomer(Customer customer) => datasource.addCustomer(customer);

  @override
  Future<void> updateCustomer(Customer customer) => datasource.updateCustomer(customer);

  @override
  Future<void> deleteCustomer(String id) => datasource.deleteCustomer(id);

  @override
  Future<List<Customer>> getAllCustomers() => datasource.getAllCustomers();

  @override
  Future<Customer?> getCustomerById(String id) => datasource.getCustomerById(id);
}
