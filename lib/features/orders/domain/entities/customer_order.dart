class CustomerOrder {
  final String id;
  final String customerId;
  final String productCode;
  final double unitPrice;
  final int quantity;
  final DateTime date;

  CustomerOrder({
    required this.id,
    required this.customerId,
    required this.productCode,
    required this.unitPrice,
    required this.quantity,
    required this.date,
  });
}
