import '../entities/customer.dart';

abstract class CustomerRepository {
  Future<void> addCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(String id);
  Future<List<Customer>> getAllCustomers();
  Future<Customer?> getCustomerById(String id);
}
