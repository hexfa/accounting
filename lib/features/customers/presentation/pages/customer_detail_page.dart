import 'package:accounting/features/orders/domain/use_cases/delete_order.dart';
import 'package:accounting/features/orders/domain/use_cases/get_orders_for_customer.dart';
import 'package:flutter/material.dart';
import 'package:accounting/features/customers/domain/entities/customer.dart';
import 'package:accounting/features/orders/domain/entities/customer_order.dart';
import 'package:accounting/core/di/injection.dart';
import 'package:intl/intl.dart';

class CustomerDetailPage extends StatefulWidget {
  final Customer customer;
  const CustomerDetailPage({super.key, required this.customer});
  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}


class _CustomerDetailPageState extends State<CustomerDetailPage> {
  late Future<List<CustomerOrder>> _ordersFuture;
  @override
  void initState() {
    super.initState();
    _ordersFuture = _loadOrders();
  }
  Future<List<CustomerOrder>> _loadOrders() async {
    final usecase = getIt<GetOrdersForCustomer>();
    final result = await usecase.execute(widget.customer.id);
    return result.fold((f) => [], (orders) => orders);
  }
  @override
  Widget build(BuildContext context) {
    final customer = widget.customer;

    return Scaffold(
      appBar: AppBar(title: const Text('جزئیات مشتری')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('👤 ${customer.firstName} ${customer.lastName}', style: Theme.of(context).textTheme.titleLarge),
            Text('📞 ${customer.phone}'),
            Text('🏠 ${customer.address}'),

            Text('📮 کد پستی: ${customer.postalCode}'),
            Text('📅 ثبت‌شده در: ${DateFormat.yMd().format(customer.createdAt)}'),
            const Divider(height: 32),
            const Text('📦 سفارش‌های قبلی', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<CustomerOrder>>(
                future: _ordersFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final orders = snapshot.data!;
                  if (orders.isEmpty) return const Text("سفارشی ثبت نشده.");

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (_, index) {
                      final order = orders[index];
                      final total = order.items.fold<double>(0, (sum, item) => sum + item.totalPrice);
                      return ExpansionTile(
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'حذف سفارش',
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("حذف سفارش"),
                                content: const Text("آیا از حذف این سفارش مطمئن هستید؟"),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("خیر")),
                                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("بله")),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await getIt<DeleteOrder>().execute(order.id);
                              setState(() {
                                _ordersFuture = _loadOrders(); // رفرش لیست بعد از حذف
                              });
                            }
                          },
                        ),

                        title: Text("🧾 سفارش ${index + 1} - ${DateFormat.yMd().format(order.date)}"),
                        subtitle: Text("تعداد اقلام: ${order.items.length} | مبلغ کل: ${total.toStringAsFixed(0)} تومان"),
                        children: order.items.map((item) {
                          return ListTile(
                            title: Text(item.productName),
                            subtitle: Text("تعداد: ${item.quantity} × ${item.unitPrice.toStringAsFixed(0)}"),
                            trailing: Text("${item.totalPrice.toStringAsFixed(0)} تومان"),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
