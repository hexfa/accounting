class CustomerOrder {
  final String id;
  final String customerId;
  final DateTime date;
  final List<OrderItem> items;

  CustomerOrder({
    required this.id,
    required this.customerId,
    required this.date,
    required this.items,
  });
}

class OrderItem {
  final String productCode;
  final String productName;
  final int quantity;
  final double unitPrice;

  OrderItem({
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => quantity * unitPrice;

  OrderItem copyWith({
    String? productCode,
    String? productName,
    int? quantity,
    double? unitPrice,
  }) {
    return OrderItem(
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}

