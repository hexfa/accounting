import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:accounting/features/products/domain/use_cases/add_product.dart';
import 'package:accounting/features/products/domain/use_cases/delete_product.dart';
import 'package:accounting/features/products/domain/use_cases/get_all_product.dart';
import 'package:accounting/features/products/domain/use_cases/update_product.dart';
import 'package:accounting/features/products/presentation/manager/product_event.dart';
import 'package:accounting/features/products/presentation/manager/product_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProduct addProduct;
  final GetAllProducts getAllProducts;
  final DeleteProduct deleteProduct;
  final UpdateProduct updateProduct;

  List<Product> _allProducts = [];

  ProductBloc({
    required this.addProduct,
    required this.getAllProducts,
    required this.deleteProduct,
    required this.updateProduct,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProductEvent>(_onAddProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await getAllProducts.execute();
    result.fold(
          (failure) => emit(ProductError(failure.message)),
          (products) {
        _allProducts = products;
        emit(ProductLoaded(products));
      },
    );
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    await addProduct.execute(event.product);
    add(LoadProducts());
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    await deleteProduct.execute(event.product);
    add(LoadProducts());
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    await updateProduct.execute(UpdateProductParams(
      oldProduct: event.oldProduct,
      updatedProduct: event.updatedProduct,
    ));
    add(LoadProducts());
  }

  void _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) {
    final query = event.query.toLowerCase();
    final filtered = _allProducts.where((p) =>
    p.name.toLowerCase().contains(query) ||
        p.code.toLowerCase().contains(query)).toList();
    emit(ProductLoaded(filtered));
  }
}
