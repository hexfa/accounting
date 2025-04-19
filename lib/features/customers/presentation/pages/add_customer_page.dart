import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/customer.dart';
import '../manager/customer_bloc.dart';
import '../manager/customer_event.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newCustomer = Customer(
      id: const Uuid().v4(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      address: _addressController.text.trim(),
      postalCode: _postalCodeController.text.trim(),
      phone: _phoneController.text.trim(),
      createdAt: DateTime.now(),
    );

    context.read<CustomerBloc>().add(AddCustomerEvent(newCustomer));

    Navigator.pop(context); // بازگشت به لیست
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('➕ افزودن مشتری')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(
                controller: _firstNameController,
                label: 'نام',
                validator: (value) =>
                value == null || value.isEmpty ? 'نام را وارد کنید' : null,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _lastNameController,
                label: 'نام خانوادگی',
                validator: (value) =>
                value == null || value.isEmpty ? 'نام خانوادگی را وارد کنید' : null,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _addressController,
                label: 'آدرس',
                validator: (value) =>
                value == null || value.isEmpty ? 'آدرس را وارد کنید' : null,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _postalCodeController,
                label: 'کد پستی',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'کد پستی الزامی است';
                  if (value.length != 10) return 'کد پستی باید 10 رقم باشد';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _phoneController,
                label: 'شماره تلفن',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'شماره تلفن الزامی است';
                  if (!RegExp(r'^09\d{9}$').hasMatch(value)) {
                    return 'شماره تلفن معتبر نیست';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.person_add),
                label: const Text('ثبت مشتری'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
