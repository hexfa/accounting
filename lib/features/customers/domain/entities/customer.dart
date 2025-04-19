class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String address;
  final String postalCode;
  final String phone;
  final DateTime createdAt;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.postalCode,
    required this.phone,
    required this.createdAt,
  });
}
