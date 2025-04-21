import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/customer.dart';
import '../manager/customer_bloc.dart';
import '../manager/customer_event.dart';
import '../manager/customer_state.dart';
import 'package:go_router/go_router.dart';
import 'package:accounting/core/navigation/app_router.dart';


class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  String searchQuery = '';
  bool sortDescending = true; // جدیدترین اول

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(LoadCustomersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👥 مشتری‌ها'),
        actions: [
          IconButton(
            icon: Icon(sortDescending ? Icons.arrow_downward : Icons.arrow_upward),
            tooltip: sortDescending ? 'مرتب‌سازی جدیدترین' : 'مرتب‌سازی قدیمی‌ترین',
            onPressed: () {
              setState(() {
                sortDescending = !sortDescending;
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'جستجو بر اساس نام',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
                if (state is CustomerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CustomerLoaded) {
                  List<Customer> filtered = state.customers
                      .where((c) =>
                  c.firstName.toLowerCase().contains(searchQuery) ||
                      c.lastName.toLowerCase().contains(searchQuery))
                      .toList();

                  // فرض بر اینه که ترتیب ورود در دیتابیس ترتیب زمانیه
                  if (sortDescending) {
                    filtered = filtered.reversed.toList();
                  }

                  if (filtered.isEmpty) {
                    return const Center(child: Text('نتیجه‌ای یافت نشد.'));
                  }

                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final customer = filtered[index];
                      return ListTile(
                        title: Text('${customer.firstName} ${customer.lastName}'),
                        subtitle: Text('📞 ${customer.phone}'),
                        onTap: () {
                          context.pushNamed(AppRoutePath.customerDetail, pathParameters: {'id': customer.id});
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context
                                .read<CustomerBloc>()
                                .add(DeleteCustomerEvent(customer.id));
                          },
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutePath.addCustomer); // ← مسیر روتر
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
