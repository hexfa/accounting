import 'package:accounting/features/orders/data/data_sources/order_local_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/repositories/order_repository.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDatasource datasource;

  OrderRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, void>> addOrder(CustomerOrder order) async {
    try {
      await datasource.addOrder(order);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('خطا در ثبت سفارش: $e'));
    }
  }
  @override
  Future<Either<Failure, void>> deleteOrder(String orderId) async {
    try {
      await datasource.deleteOrder(orderId);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('خطا در حذف سفارش: $e'));
    }
  }


  @override
  Future<Either<Failure, List<CustomerOrder>>> getOrdersForCustomer(String customerId) async {
    try {
      final orders = await datasource.getOrdersForCustomer(customerId);
      return Right(orders);
    } catch (e) {
      return Left(UnknownFailure('خطا در دریافت سفارش‌ها: $e'));
    }
  }
}
