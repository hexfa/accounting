import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accounting/core/di/injection.dart';
import 'package:accounting/core/presentation/bloc/network_info/network_info_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
    BlocProvider(create: (_) => getIt<NetworkInfoBloc>()),
      ];
}
