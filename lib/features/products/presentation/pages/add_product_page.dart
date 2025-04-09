import 'package:accounting/features/products/presentation/manager/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:accounting/features/products/presentation/manager/product_bloc.dart';
import 'package:accounting/features/products/presentation/manager/product_event.dart';

class AddProductPage extends StatefulWidget {
  final Product? productToEdit;

  const AddProductPage({super.key, this.productToEdit});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final priceController = TextEditingController();

  bool get isEditing => widget.productToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      nameController.text = widget.productToEdit!.name;
      codeController.text = widget.productToEdit!.code;
      priceController.text = widget.productToEdit!.price.toString();
    }
  }

  void _submit() {
    final name = nameController.text.trim();
    final code = codeController.text.trim();
    final price = double.tryParse(priceController.text) ?? 0;

    if (name.isEmpty || code.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("لطفاً همه فیلدها را به‌درستی وارد کنید.")),
      );
      return;
    }

    final newProduct = Product(name: name, code: code, price: price);
    final bloc = context.read<ProductBloc>();
    final state = bloc.state;

    if (state is ProductLoaded) {
      final isDuplicate = state.products.any((p) {
        if (isEditing && p.code == widget.productToEdit!.code) {
          return false;
        }
        return p.code == code;
      });

      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❗ این کد محصول قبلاً ثبت شده است.")),
        );
        return;
      }
    }

    if (isEditing) {
      bloc.add(UpdateProductEvent(widget.productToEdit!, newProduct));
    } else {
      bloc.add(AddProductEvent(newProduct));
    }

    Navigator.pop(context, true); // ← موفقیت
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'ویرایش محصول' : 'افزودن محصول')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'نام محصول'),
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'کد محصول'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'قیمت محصول'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(isEditing ? 'ذخیره تغییرات' : 'افزودن'),
            ),
          ],
        ),
      ),
    );
  }
}
