import '../../domain/entities/customer_order.dart';
import 'package:hive/hive.dart';
import '../models/order_model.dart';
import 'order_local_datasource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderLocalDatasource)
class HiveOrderLocalDatasource implements OrderLocalDatasource {
  static const String boxName = 'orders';

  Future<Box<OrderModel>> _openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<OrderModel>(boxName);
    }
    return Hive.box<OrderModel>(boxName);
  }

  @override
  Future<void> addOrder(Order order) async {
    final box = await _openBox();
    await box.put(order.id, OrderModel.fromEntity(order));
  }

  @override
  Future<List<Order>> getOrdersForCustomer(String customerId) async {
    final box = await _openBox();
    return box.values
        .where((e) => e.customerId == customerId)
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    final box = await _openBox();
    await box.delete(orderId);
  }
}

abstract class OrderLocalDatasource {
  Future<void> addOrder(Order order);
  Future<List<Order>> getOrdersForCustomer(String customerId);
  Future<void> deleteOrder(String orderId);
}
