import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/customer_order.dart';

abstract class OrderRepository {
  Future<Either<Failure, void>> addOrder(CustomerOrder order);
  Future<Either<Failure, List<CustomerOrder>>> getOrdersForCustomer(String customerId);
  Future<Either<Failure, void>> deleteOrder(String orderId); // 👈 اضافه شد
  Future<Either<Failure, List<CustomerOrder>>> getAllOrders();

}

