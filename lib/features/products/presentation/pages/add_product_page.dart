import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accounting/features/products/presentation/manager/product_bloc.dart';
import 'package:accounting/features/products/presentation/manager/product_event.dart';
import 'package:accounting/features/products/presentation/manager/product_state.dart';
import 'package:accounting/features/products/domain/entities/product.dart';

class AddProductPage extends StatefulWidget {
  final Product? productToEdit;

  const AddProductPage({super.key, this.productToEdit});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final quantityController = TextEditingController();
  final wholesalePriceController = TextEditingController();
  final retailPriceController = TextEditingController();

  bool get isEditing => widget.productToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final p = widget.productToEdit!;
      nameController.text = p.name;
      codeController.text = p.code;
      quantityController.text = p.quantity.toString();
      wholesalePriceController.text = p.wholesalePrice.toString();
      retailPriceController.text = p.retailPrice.toString();
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final name = nameController.text.trim();
    final code = codeController.text.trim();
    final quantity = int.tryParse(quantityController.text) ?? 0;
    final wholesalePrice = double.tryParse(wholesalePriceController.text) ?? 0;
    final retailPrice = double.tryParse(retailPriceController.text) ?? 0;

    final newProduct = Product(
      name: name,
      code: code,
      quantity: quantity,
      wholesalePrice: wholesalePrice,
      retailPrice: retailPrice,
    );

    final bloc = context.read<ProductBloc>();
    final state = bloc.state;

    // جلوگیری از کد تکراری
    if (state is ProductLoaded) {
      final isDuplicate = state.products.any((p) {
        if (isEditing && p.code == widget.productToEdit!.code) return false;
        return p.code == code;
      });

      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❗ کد محصول تکراری است')),
        );
        return;
      }
    }

    if (isEditing) {
      bloc.add(UpdateProductEvent(widget.productToEdit!, newProduct));
    } else {
      bloc.add(AddProductEvent(newProduct));
    }

    Navigator.pop(context, true);
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
      appBar: AppBar(title: Text(isEditing ? 'ویرایش محصول' : 'افزودن محصول')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(
                controller: nameController,
                label: 'نام محصول',
                validator: (value) =>
                value == null || value.trim().isEmpty ? 'نام را وارد کنید' : null,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: codeController,
                label: 'کد محصول',
                validator: (value) =>
                value == null || value.trim().isEmpty ? 'کد را وارد کنید' : null,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: quantityController,
                label: 'تعداد',
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  if (number == null || number < 0) return 'تعداد نامعتبر است';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: wholesalePriceController,
                label: 'قیمت عمده',
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = double.tryParse(value ?? '');
                  if (number == null || number <= 0) return 'قیمت عمده نامعتبر است';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: retailPriceController,
                label: 'قیمت فروش',
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = double.tryParse(value ?? '');
                  if (number == null || number <= 0) return 'قیمت فروش نامعتبر است';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: Icon(isEditing ? Icons.save : Icons.add),
                label: Text(isEditing ? 'ذخیره تغییرات' : 'افزودن محصول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
