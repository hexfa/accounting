import 'package:hive/hive.dart';
import '../../domain/entities/customer_order.dart';

part 'order_item_model.g.dart';

@HiveType(typeId: 3)
class OrderItemModel extends HiveObject {
  @HiveField(0)
  final String productCode;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final double unitPrice;

  OrderItemModel({
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderItemModel.fromEntity(OrderItem item) {
    return OrderItemModel(
      productCode: item.productCode,
      productName: item.productName,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
    );
  }

  OrderItem toEntity() {
    return OrderItem(
      productCode: productCode,
      productName: productName,
      quantity: quantity,
      unitPrice: unitPrice,
    );
  }
}
