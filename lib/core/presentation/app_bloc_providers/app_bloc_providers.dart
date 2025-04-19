import 'package:accounting/core/di/injection.dart';
import 'package:accounting/core/presentation/bloc/network_info/network_info_bloc.dart';
import 'package:accounting/features/customers/presentation/manager/customer_bloc.dart';
import 'package:accounting/features/customers/presentation/manager/customer_event.dart';
import 'package:accounting/features/products/presentation/manager/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
    BlocProvider(create: (_) => getIt<NetworkInfoBloc>()),
    BlocProvider(create: (_) => getIt<ProductBloc>()),
    BlocProvider(create: (_) => getIt<CustomerBloc>()..add(LoadCustomersEvent()),),
  ];
}
