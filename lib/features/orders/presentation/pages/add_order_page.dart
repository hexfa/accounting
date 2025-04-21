import 'package:accounting/features/orders/domain/use_cases/add_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:accounting/features/products/presentation/manager/product_bloc.dart';
import 'package:accounting/features/products/presentation/manager/product_state.dart';
import 'package:accounting/features/orders/domain/entities/customer_order.dart';
import 'package:accounting/features/customers/domain/entities/customer.dart';
import 'package:accounting/core/di/injection.dart';

class AddOrderPage extends StatefulWidget {
  final Customer customer;

  const AddOrderPage({super.key, required this.customer});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final Map<String, TextEditingController> quantityControllers = {};

  double calculateTotal(List<Product> products) {
    double total = 0;
    for (var product in products) {
      final qty = int.tryParse(quantityControllers[product.code]?.text ?? '') ?? 0;
      if (qty > 0) {
        total += qty * product.retailPrice;
      }
    }
    return total;
  }

  void submit(List<Product> products) async {
    final selectedItems = <OrderItem>[];

    for (var product in products) {
      final qty = int.tryParse(quantityControllers[product.code]?.text ?? '') ?? 0;
      if (qty > 0) {
        selectedItems.add(OrderItem(
          productCode: product.code,
          productName: product.name,
          quantity: qty,
          unitPrice: product.retailPrice,
        ));
      }
    }

    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("حداقل یک محصول را انتخاب کنید.")),
      );
      return;
    }

    final order = CustomerOrder(
      id: const Uuid().v4(),
      customerId: widget.customer.id,
      date: DateTime.now(),
      items: selectedItems,
    );

    final addOrder = getIt<AddOrder>();
    await addOrder.execute(order);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🛒 ثبت سفارش")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text("برای: ${widget.customer.firstName} ${widget.customer.lastName}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final products = state.products;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      quantityControllers.putIfAbsent(product.code, () => TextEditingController());
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text("قیمت: ${product.retailPrice.toStringAsFixed(0)}"),
                        trailing: SizedBox(
                          width: 70,
                          child: TextField(
                            controller: quantityControllers[product.code],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: 'تعداد'),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('خطا در دریافت محصولات.'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final total = calculateTotal(state.products);
                  return Column(
                    children: [
                      Text('💰 مجموع: ${total.toStringAsFixed(0)} تومان'),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () => submit(state.products),
                        icon: const Icon(Icons.save),
                        label: const Text("ثبت سفارش"),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
