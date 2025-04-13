import 'package:hive/hive.dart';

import '../../domain/entities/customer.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 1)
class CustomerModel extends Customer {
  @HiveField(0)
  final String hiveId;

  @HiveField(1)
  final String hiveFirstName;

  @HiveField(2)
  final String hiveLastName;

  @HiveField(3)
  final String hiveAddress;

  @HiveField(4)
  final String hivePostalCode;

  @HiveField(5)
  final String hivePhone;

  CustomerModel({
    required this.hiveId,
    required this.hiveFirstName,
    required this.hiveLastName,
    required this.hiveAddress,
    required this.hivePostalCode,
    required this.hivePhone,
  }) : super(
    id: hiveId,
    firstName: hiveFirstName,
    lastName: hiveLastName,
    address: hiveAddress,
    postalCode: hivePostalCode,
    phone: hivePhone,
  );

  factory CustomerModel.fromEntity(Customer customer) {
    return CustomerModel(
      hiveId: customer.id,
      hiveFirstName: customer.firstName,
      hiveLastName: customer.lastName,
      hiveAddress: customer.address,
      hivePostalCode: customer.postalCode,
      hivePhone: customer.phone,
    );
  }

  Customer toEntity() {
    return Customer(
      id: hiveId,
      firstName: hiveFirstName,
      lastName: hiveLastName,
      address: hiveAddress,
      postalCode: hivePostalCode,
      phone: hivePhone,
    );
  }
}
