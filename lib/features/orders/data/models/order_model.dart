import 'package:hive/hive.dart';

import '../../domain/entities/customer_order.dart';

part 'order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel extends CustomerOrder {
  @HiveField(0)
  final String hiveId;

  @HiveField(1)
  final String hiveCustomerId;

  @HiveField(2)
  final String hiveProductCode;

  @HiveField(3)
  final double hiveUnitPrice;

  @HiveField(4)
  final int hiveQuantity;

  @HiveField(5)
  final DateTime hiveDate;

  OrderModel({
    required this.hiveId,
    required this.hiveCustomerId,
    required this.hiveProductCode,
    required this.hiveUnitPrice,
    required this.hiveQuantity,
    required this.hiveDate,
  }) : super(
    id: hiveId,
    customerId: hiveCustomerId,
    productCode: hiveProductCode,
    unitPrice: hiveUnitPrice,
    quantity: hiveQuantity,
    date: hiveDate,
  );

  factory OrderModel.fromEntity(CustomerOrder order) {
    return OrderModel(
      hiveId: order.id,
      hiveCustomerId: order.customerId,
      hiveProductCode: order.productCode,
      hiveUnitPrice: order.unitPrice,
      hiveQuantity: order.quantity,
      hiveDate: order.date,
    );
  }

  CustomerOrder toEntity() {
    return CustomerOrder(
      id: hiveId,
      customerId: hiveCustomerId,
      productCode: hiveProductCode,
      unitPrice: hiveUnitPrice,
      quantity: hiveQuantity,
      date: hiveDate,
    );
  }
}
