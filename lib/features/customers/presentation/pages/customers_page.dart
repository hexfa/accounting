import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/customer.dart';
import '../manager/customer_bloc.dart';
import '../manager/customer_event.dart';
import '../manager/customer_state.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('👥 مشتری‌ها')),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerLoaded) {
            final customers = state.customers;
            if (customers.isEmpty) {
              return const Center(child: Text('هیچ مشتری ثبت نشده است.'));
            }

            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return ListTile(
                  title: Text('${customer.firstName} ${customer.lastName}'),
                  subtitle: Text('📞 ${customer.phone}'),
                  onTap: () {
                    // TODO: رفتن به صفحه جزئیات مشتری
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // TODO: رفتن به صفحه ویرایش مشتری
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<CustomerBloc>().add(DeleteCustomerEvent(customer.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is CustomerError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: رفتن به صفحه افزودن مشتری
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
