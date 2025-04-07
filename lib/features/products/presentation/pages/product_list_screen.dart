import 'package:accounting/features/products/presentation/manager/product_bloc.dart';
import 'package:accounting/features/products/presentation/manager/product_event.dart';
import 'package:accounting/features/products/presentation/manager/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

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
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      final product = products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('کد: ${product.code} - قیمت: ${product.price}'),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              // برو به صفحه افزودن برای ویرایش
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
        onPressed: () {
          Navigator.pushNamed(context, '/add-product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
