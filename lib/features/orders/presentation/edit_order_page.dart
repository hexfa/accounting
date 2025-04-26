import 'package:accounting/features/orders/domain/use_cases/add_order.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:accounting/features/orders/domain/entities/customer_order.dart';
import 'package:accounting/core/di/injection.dart';
import 'package:intl/intl.dart';

class EditOrderPage extends StatefulWidget {
  final CustomerOrder order;

  const EditOrderPage({super.key, required this.order});

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  late List<OrderItem> items;
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    items = List.from(widget.order.items);
    for (var item in items) {
      controllers[item.productCode] = TextEditingController(text: item.quantity.toString());
    }
  }

  double get total {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }
  void _submit() async {
    final updatedItems = <OrderItem>[];
    for (var item in items) {
      final qty = int.tryParse(controllers[item.productCode]?.text ?? '0') ?? 0;
      if (qty > 0) {
        updatedItems.add(item.copyWith(quantity: qty));
      }
    }
    if (updatedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("حداقل یک محصول باید باقی بماند.")));
      return;
    }
    final updatedOrder = CustomerOrder(
      id: widget.order.id,
      customerId: widget.order.customerId,
      date: DateTime.now(),
      items: updatedItems,
    );
    await getIt<AddOrder>().execute(updatedOrder); // همون AddOrder برای ویرایش هم استفاده میشه
    Navigator.pop(context);
  }
  void _removeItem(OrderItem item) {
    setState(() {
      items.remove(item);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ویرایش سفارش')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                final controller = controllers[item.productCode]!;

                return ListTile(
                  title: Text(item.productName),
                  subtitle: Row(
                    children: [
                      Text('قیمت: ${item.unitPrice.toStringAsFixed(0)} تومان'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'تعداد'),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeItem(item),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('💰 مجموع جدید: ${total.toStringAsFixed(0)} تومان'),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.save),
                  label: const Text('ذخیره تغییرات'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
