import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accounting/core/navigation/app_router.dart';
import 'package:accounting/features/products/presentation/manager/product_bloc.dart';
import 'package:accounting/features/products/presentation/manager/product_event.dart';
import 'package:accounting/features/products/presentation/manager/product_state.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📦 محصولات')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(labelText: 'جستجو بر اساس نام یا کد'),
              onChanged: (value) {
                context.read<ProductBloc>().add(SearchProductsEvent(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return const Center(child: Text('محصولی یافت نشد.'));
                  }
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      final product = products[index];
                      final isOutOfStock = product.quantity <= 0;

                      return GestureDetector(
                        onTap: () {
                          final int sold = 0; // فرض فعلاً
                          final int remaining = product.quantity;
                          final double profit = sold * (product.retailPrice - product.wholesalePrice);

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(product.name),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('کد محصول: ${product.code}'),
                                  Text('قیمت فروش: ${product.retailPrice}'),
                                  Text('قیمت عمده: ${product.wholesalePrice}'),
                                  Text('تعداد باقی‌مانده: $remaining'),
                                  Text('تعداد فروش‌رفته: $sold'),
                                  Text('💰 سود کل تا الان: ${profit.toStringAsFixed(2)}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('بستن'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(child: Text(product.name)),
                              if (isOutOfStock)
                                const Icon(Icons.warning, color: Colors.red, size: 18),
                            ],
                          ),
                          subtitle: Text(
                            'کد: ${product.code} | تعداد: ${product.quantity} | قیمت: ${product.retailPrice}',
                            style: TextStyle(
                              color: isOutOfStock ? Colors.redAccent : null,
                            ),
                          ),
                          tileColor: isOutOfStock ? Colors.red.withOpacity(0.1) : null,
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                Navigator.pushNamed(context, '/add-product', arguments: product);
                              } else if (value == 'delete') {
                                context.read<ProductBloc>().add(DeleteProductEvent(product));
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Text('ویرایش')),
                              const PopupMenuItem(value: 'delete', child: Text('حذف')),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.pushNamed(AppRoutePath.addProduct);
          if (result == true) {
            context.read<ProductBloc>().add(LoadProducts());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
