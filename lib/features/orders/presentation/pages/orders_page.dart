import 'package:accounting/features/orders/domain/use_cases/delete_order.dart';
import 'package:accounting/features/orders/domain/use_cases/get_all_orders.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:accounting/core/di/injection.dart';
import 'package:accounting/features/orders/domain/entities/customer_order.dart';

import 'package:accounting/core/navigation/app_router.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<CustomerOrder>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _loadOrders();
  }

  Future<List<CustomerOrder>> _loadOrders() async {
    final usecase = getIt<GetAllOrders>();
    final result = await usecase.execute();
    return result.fold((failure) => [], (orders) => orders);
  }

  void _deleteOrder(String orderId) async {
    await getIt<DeleteOrder>().execute(orderId);
    setState(() {
      _ordersFuture = _loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🧾 همه سفارش‌ها')),
      body: FutureBuilder<List<CustomerOrder>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final orders = snapshot.data!;
          if (orders.isEmpty) return const Center(child: Text('هیچ سفارشی ثبت نشده.'));

          orders.sort((a, b) => b.date.compareTo(a.date)); // مرتب سازی جدیدترین به قدیمی‌ترین

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (_, index) {
              final order = orders[index];
              final total = order.items.fold<double>(0, (sum, item) => sum + item.totalPrice);

              return ListTile(
                title: Text('سفارش ${index + 1} - ${DateFormat.yMd().format(order.date)}'),
                subtitle: Text('تعداد اقلام: ${order.items.length} | مبلغ کل: ${total.toStringAsFixed(0)} تومان'),
                onTap: () {
                  context.pushNamed(AppRoutePath.editOrder, extra: order);
                },
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
                      _deleteOrder(order.id);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
