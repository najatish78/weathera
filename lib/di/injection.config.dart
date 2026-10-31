// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:weathera/core/data/datasource/base_local_datasource.dart'
    as _i1070;
import 'package:weathera/core/data/datasource/base_remote_datasource.dart'
    as _i861;
import 'package:weathera/core/data/datasource/theme_local_datasource.dart'
    as _i614;
import 'package:weathera/core/data/network/network_Info.dart' as _i904;
import 'package:weathera/core/data/network/network_info.dart' as _i768;
import 'package:weathera/core/domain/presentation/blocs/theme_bloc/theme_bloc.dart'
    as _i213;
import 'package:weathera/di/modules/injectable_module.dart' as _i689;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => injectableModule.createConnectionChecker(),
    );
    gh.lazySingleton<_i1070.BaseLocalDataSource>(
      () => _i1070.BaseLocalDataSourceImp(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i861.BaseRemoteDataSourceImpl>(
      () => _i861.BaseRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i614.ThemeLocalDataSource>(
      () => _i614.ThemeLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i904.NetworkInfo>(
      () => _i904.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.lazySingleton<_i768.NetworkInfo>(
      () => _i768.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.singleton<_i213.ThemeBloc>(
      () => _i213.ThemeBloc(
        baseLocalDataSourcel: gh<_i614.ThemeLocalDataSource>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i689.InjectableModule {}
