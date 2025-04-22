// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:accounting/core/data/storage_services/secure_storage.dart'
    as _i270;
import 'package:accounting/core/di/module/injectable_module.dart' as _i984;
import 'package:accounting/core/presentation/bloc/network_info/network_info_bloc.dart'
    as _i260;
import 'package:accounting/core/shared/utilities/network_info.dart' as _i152;
import 'package:accounting/features/customers/data/data_sources/customer_local_datasource.dart'
    as _i903;
import 'package:accounting/features/customers/data/repositories/customer_repository_impl.dart'
    as _i243;
import 'package:accounting/features/customers/domain/repositories/customer_repository.dart'
    as _i950;
import 'package:accounting/features/customers/domain/use_cases/add_customer.dart'
    as _i1053;
import 'package:accounting/features/customers/domain/use_cases/delete_customer.dart'
    as _i802;
import 'package:accounting/features/customers/domain/use_cases/get_all_customers.dart'
    as _i75;
import 'package:accounting/features/customers/domain/use_cases/get_customer_by_id.dart'
    as _i305;
import 'package:accounting/features/customers/domain/use_cases/update_customer.dart'
    as _i917;
import 'package:accounting/features/customers/presentation/manager/customer_bloc.dart'
    as _i279;
import 'package:accounting/features/orders/data/data_sources/order_local_datasource.dart'
    as _i236;
import 'package:accounting/features/orders/data/repositories/order_repository_impl.dart'
    as _i290;
import 'package:accounting/features/orders/domain/repositories/order_repository.dart'
    as _i407;
import 'package:accounting/features/orders/domain/use_cases/add_order.dart'
    as _i488;
import 'package:accounting/features/orders/domain/use_cases/get_orders_for_customer.dart'
    as _i1068;
import 'package:accounting/features/products/data/data_sources/local/product_local_data_source.dart'
    as _i617;
import 'package:accounting/features/products/data/repositories/product_repository_impl.dart'
    as _i782;
import 'package:accounting/features/products/domain/repositories/product_repository.dart'
    as _i750;
import 'package:accounting/features/products/domain/use_cases/add_product.dart'
    as _i806;
import 'package:accounting/features/products/domain/use_cases/delete_product.dart'
    as _i708;
import 'package:accounting/features/products/domain/use_cases/get_all_product.dart'
    as _i463;
import 'package:accounting/features/products/domain/use_cases/update_product.dart'
    as _i804;
import 'package:accounting/features/products/presentation/manager/product_bloc.dart'
    as _i180;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:uuid/uuid.dart' as _i706;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i706.Uuid>(() => injectableModule.uuid);
    gh.lazySingleton<_i895.Connectivity>(() => injectableModule.connectivity);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => injectableModule.internetConnectionChecker);
    gh.lazySingleton<_i152.NetworkInfoImpl>(() => injectableModule.networkInfo);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => injectableModule.storage);
    gh.lazySingleton<_i270.SecureStorage>(() => injectableModule.secureStorage);
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dio);
    gh.lazySingleton<_i236.OrderLocalDatasource>(
        () => _i236.HiveOrderLocalDatasource());
    gh.lazySingleton<_i407.OrderRepository>(
        () => _i290.OrderRepositoryImpl(gh<_i236.OrderLocalDatasource>()));
    gh.lazySingleton<_i152.NetworkInfo>(() => _i152.NetworkInfoImpl(
          connectivity: gh<_i895.Connectivity>(),
          internetConnectionChecker: gh<_i973.InternetConnectionChecker>(),
        ));
    gh.lazySingleton<_i617.ProductLocalDatasource>(
        () => _i617.HiveProductLocalDatasource());
    gh.lazySingleton<_i903.CustomerLocalDatasource>(
        () => _i903.HiveCustomerLocalDatasource());
    gh.factory<_i260.NetworkInfoBloc>(() => _i260.NetworkInfoBloc(
          networkInfo: gh<_i152.NetworkInfo>(),
          connectivity: gh<_i895.Connectivity>(),
        ));
    gh.lazySingleton<_i950.CustomerRepository>(() =>
        _i243.CustomerRepositoryImpl(gh<_i903.CustomerLocalDatasource>()));
    gh.lazySingleton<_i488.AddOrder>(
        () => _i488.AddOrder(gh<_i407.OrderRepository>()));
    gh.lazySingleton<_i1068.GetOrdersForCustomer>(
        () => _i1068.GetOrdersForCustomer(gh<_i407.OrderRepository>()));
    gh.lazySingleton<_i750.ProductRepository>(
        () => _i782.ProductRepositoryImpl(gh<_i617.ProductLocalDatasource>()));
    gh.lazySingleton<_i806.AddProduct>(
        () => _i806.AddProduct(gh<_i750.ProductRepository>()));
    gh.lazySingleton<_i708.DeleteProduct>(
        () => _i708.DeleteProduct(gh<_i750.ProductRepository>()));
    gh.lazySingleton<_i463.GetAllProducts>(
        () => _i463.GetAllProducts(gh<_i750.ProductRepository>()));
    gh.lazySingleton<_i804.UpdateProduct>(
        () => _i804.UpdateProduct(gh<_i750.ProductRepository>()));
    gh.factory<_i180.ProductBloc>(() => _i180.ProductBloc(
          addProduct: gh<_i806.AddProduct>(),
          getAllProducts: gh<_i463.GetAllProducts>(),
          deleteProduct: gh<_i708.DeleteProduct>(),
          updateProduct: gh<_i804.UpdateProduct>(),
        ));
    gh.lazySingleton<_i1053.AddCustomer>(
        () => _i1053.AddCustomer(gh<_i950.CustomerRepository>()));
    gh.lazySingleton<_i802.DeleteCustomer>(
        () => _i802.DeleteCustomer(gh<_i950.CustomerRepository>()));
    gh.lazySingleton<_i75.GetAllCustomers>(
        () => _i75.GetAllCustomers(gh<_i950.CustomerRepository>()));
    gh.lazySingleton<_i305.GetCustomerById>(
        () => _i305.GetCustomerById(gh<_i950.CustomerRepository>()));
    gh.lazySingleton<_i917.UpdateCustomer>(
        () => _i917.UpdateCustomer(gh<_i950.CustomerRepository>()));
    gh.factory<_i279.CustomerBloc>(() => _i279.CustomerBloc(
          addCustomer: gh<_i1053.AddCustomer>(),
          updateCustomer: gh<_i917.UpdateCustomer>(),
          deleteCustomer: gh<_i802.DeleteCustomer>(),
          getAllCustomers: gh<_i75.GetAllCustomers>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i984.InjectableModule {}
