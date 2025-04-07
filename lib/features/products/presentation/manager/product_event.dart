import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product product;

  AddProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final Product product;

  DeleteProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final Product oldProduct;
  final Product updatedProduct;

  UpdateProductEvent(this.oldProduct, this.updatedProduct);

  @override
  List<Object?> get props => [oldProduct, updatedProduct];
}

class SearchProductsEvent extends ProductEvent {
  final String query;

  SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
