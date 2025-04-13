import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/customer.dart';
import '../models/customer_model.dart';

@LazySingleton(as: CustomerLocalDatasource)
class HiveCustomerLocalDatasource implements CustomerLocalDatasource {
  static const String boxName = 'customers';

  Future<Box<CustomerModel>> _openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<CustomerModel>(boxName);
    }
    return Hive.box<CustomerModel>(boxName);
  }

  @override
  Future<void> addCustomer(Customer customer) async {
    final box = await _openBox();
    await box.put(customer.id, CustomerModel.fromEntity(customer));
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    final box = await _openBox();
    await box.delete(customerId);
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    final box = await _openBox();
    await box.put(customer.id, CustomerModel.fromEntity(customer));
  }

  @override
  Future<List<Customer>> getAllCustomers() async {
    final box = await _openBox();
    return box.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Customer?> getCustomerById(String id) async {
    final box = await _openBox();
    final model = box.get(id);
    return model?.toEntity();
  }
}

abstract class CustomerLocalDatasource {
  Future<void> addCustomer(Customer customer);
  Future<void> deleteCustomer(String customerId);
  Future<void> updateCustomer(Customer customer);
  Future<List<Customer>> getAllCustomers();
  Future<Customer?> getCustomerById(String id);
}
