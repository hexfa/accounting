import 'package:accounting/core/di/injection.dart';
import 'package:accounting/features/customers/domain/use_cases/get_customer_by_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/customer.dart';
class CustomerDetailPage extends StatelessWidget {
  final String customerId;
  const CustomerDetailPage({super.key, required this.customerId});
  @override
  Widget build(BuildContext context) {
    final getCustomerById = getIt<GetCustomerById>();

    return FutureBuilder(
      future: getCustomerById.execute(customerId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final result = snapshot.data!;
        return result.fold(
              (failure) => Center(child: Text('❗ ${failure.message}')),
              (customer) {
            if (customer == null) return const Center(child: Text('مشتری یافت نشد.'));
            return _buildDetails(context, customer);
          },
        );
      },
    );
  }

  Widget _buildDetails(BuildContext context, Customer customer) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات مشتری'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/edit-customer/${customer.id}');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('👤 ${customer.firstName} ${customer.lastName}', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('📅 تاریخ ثبت: ${customer.createdAt.toString().substring(0, 10)}'),
            Text('🏠 آدرس: ${customer.address}'),
            Text('📮 کد پستی: ${customer.postalCode}'),
            Text('📞 تلفن: ${customer.phone}'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('ثبت سفارش جدید'),
            ),
            const SizedBox(height: 24),
            const Text('🧾 لیست سفارش‌ها:', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
