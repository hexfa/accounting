// dart format width=80
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
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i706.Uuid>(() => injectableModule.uuid);
    gh.lazySingleton<_i895.Connectivity>(() => injectableModule.connectivity);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => injectableModule.internetConnectionChecker,
    );
    gh.lazySingleton<_i152.NetworkInfoImpl>(() => injectableModule.networkInfo);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => injectableModule.storage,
    );
    gh.lazySingleton<_i270.SecureStorage>(() => injectableModule.secureStorage);
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dio);
    gh.lazySingleton<_i152.NetworkInfo>(
      () => _i152.NetworkInfoImpl(
        connectivity: gh<_i895.Connectivity>(),
        internetConnectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.factory<_i260.NetworkInfoBloc>(
      () => _i260.NetworkInfoBloc(
        networkInfo: gh<_i152.NetworkInfo>(),
        connectivity: gh<_i895.Connectivity>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i984.InjectableModule {}
