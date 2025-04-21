import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/customer_order.dart';
import '../models/order_model.dart';

abstract class OrderLocalDatasource {
  Future<void> addOrder(CustomerOrder order);
  Future<List<CustomerOrder>> getOrdersForCustomer(String customerId);
  Future<void> deleteOrder(String orderId);
}

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
  Future<void> addOrder(CustomerOrder order) async {
    final box = await _openBox();
    await box.put(order.id, OrderModel.fromEntity(order));
  }

  @override
  Future<List<CustomerOrder>> getOrdersForCustomer(String customerId) async {
    final box = await _openBox();
    return box.values
        .where((order) => order.customerId == customerId)
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    final box = await _openBox();
    await box.delete(orderId);
  }
}
