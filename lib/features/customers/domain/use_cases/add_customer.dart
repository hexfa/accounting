import 'package:injectable/injectable.dart';
import '../../../../core/use_cases/base_use_case.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

@lazySingleton
class AddCustomer extends BaseUseCase<void, Customer> {
  final CustomerRepository repository;

  AddCustomer(this.repository);

  @override
  Future<void> execute(Customer params) {
    return repository.addCustomer(params);
  }
}
