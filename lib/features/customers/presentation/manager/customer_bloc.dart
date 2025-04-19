import 'package:accounting/features/customers/domain/use_cases/add_customer.dart';
import 'package:accounting/features/customers/domain/use_cases/delete_customer.dart';
import 'package:accounting/features/customers/domain/use_cases/get_all_customers.dart';
import 'package:accounting/features/customers/domain/use_cases/update_customer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'customer_event.dart';
import 'customer_state.dart';

@injectable
class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final AddCustomer addCustomer;
  final UpdateCustomer updateCustomer;
  final DeleteCustomer deleteCustomer;
  final GetAllCustomers getAllCustomers;

  CustomerBloc({
    required this.addCustomer,
    required this.updateCustomer,
    required this.deleteCustomer,
    required this.getAllCustomers,
  }) : super(CustomerInitial()) {
    on<LoadCustomersEvent>(_onLoadCustomers);
    on<AddCustomerEvent>(_onAddCustomer);
    on<UpdateCustomerEvent>(_onUpdateCustomer);
    on<DeleteCustomerEvent>(_onDeleteCustomer);
  }

  Future<void> _onLoadCustomers(LoadCustomersEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    final result = await getAllCustomers.execute();
    result.fold(
          (failure) => emit(CustomerError(failure.message)),
          (customers) => emit(CustomerLoaded(customers)),
    );
  }

  Future<void> _onAddCustomer(AddCustomerEvent event, Emitter<CustomerState> emit) async {
    final result = await addCustomer.execute(event.customer);
    if (result.isRight()) add(LoadCustomersEvent());
  }

  Future<void> _onUpdateCustomer(UpdateCustomerEvent event, Emitter<CustomerState> emit) async {
    final result = await updateCustomer.execute(event.customer);
    if (result.isRight()) add(LoadCustomersEvent());
  }

  Future<void> _onDeleteCustomer(DeleteCustomerEvent event, Emitter<CustomerState> emit) async {
    final result = await deleteCustomer.execute(event.customerId);
    if (result.isRight()) add(LoadCustomersEvent());
  }
}
