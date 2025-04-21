import 'package:accounting/features/orders/data/models/order_item_model.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/customer_order.dart';

part 'order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String customerId;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.date,
    required this.items,
  });

  factory OrderModel.fromEntity(CustomerOrder order) {
    return OrderModel(
      id: order.id,
      customerId: order.customerId,
      date: order.date,
      items: order.items.map(OrderItemModel.fromEntity).toList(),
    );
  }

  CustomerOrder toEntity() {
    return CustomerOrder(
      id: id,
      customerId: customerId,
      date: date,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }
}

