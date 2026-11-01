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
import 'package:weathera/core/data/network/network_info.dart' as _i768;
import 'package:weathera/core/domain/presentation/blocs/theme_bloc/theme_bloc.dart'
    as _i213;
import 'package:weathera/core/services/location_helper.dart' as _i11;
import 'package:weathera/di/modules/injectable_module.dart' as _i689;
import 'package:weathera/features/outfit/data/datasource/outfit_local_datasource.dart'
    as _i626;
import 'package:weathera/features/outfit/data/datasource/outfit_remote_datasource.dart'
    as _i743;
import 'package:weathera/features/outfit/data/datasource/outfit_remote_datasource_impl.dart'
    as _i906;
import 'package:weathera/features/outfit/data/repository/outfit_repository_impl.dart'
    as _i215;
import 'package:weathera/features/outfit/domain/repository/outfit_repository.dart'
    as _i647;
import 'package:weathera/features/outfit/domain/usecase/suggest_outfit_usecase.dart'
    as _i79;
import 'package:weathera/features/weather/data/datasource/weather_remote_datasource.dart'
    as _i287;
import 'package:weathera/features/weather/data/datasource/weather_remote_datasource_impl.dart'
    as _i733;
import 'package:weathera/features/weather/data/repository/weather_repository_impl.dart'
    as _i683;
import 'package:weathera/features/weather/domain/repository/weather_repository.dart'
    as _i407;
import 'package:weathera/features/weather/domain/usecase/get_current_weather_usecase.dart'
    as _i930;
import 'package:weathera/features/weather/domain/usecase/get_forecast_usecase.dart'
    as _i511;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i11.LocationHelper>(() => _i11.LocationHelper());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => injectableModule.createConnectionChecker(),
    );
    gh.singleton<_i743.OutfitRemoteDataSource>(
      () => _i906.OutfitRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i626.OutfitLocalDataSource>(
      () => _i626.OutfitLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1070.BaseLocalDataSource>(
      () => _i1070.BaseLocalDataSourceImp(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i861.BaseRemoteDataSourceImpl>(
      () => _i861.BaseRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i287.WeatherRemoteDataSource>(
      () => _i733.WeatherRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i407.WeatherRepository>(
      () => _i683.WeatherRepositoryImpl(gh<_i287.WeatherRemoteDataSource>()),
    );
    gh.lazySingleton<_i614.ThemeLocalDataSource>(
      () => _i614.ThemeLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i930.GetCurrentWeatherUseCase>(
      () => _i930.GetCurrentWeatherUseCase(gh<_i407.WeatherRepository>()),
    );
    gh.factory<_i511.GetForecastUseCase>(
      () => _i511.GetForecastUseCase(gh<_i407.WeatherRepository>()),
    );
    gh.lazySingleton<_i768.NetworkInfo>(
      () => _i768.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.singleton<_i213.ThemeBloc>(
      () => _i213.ThemeBloc(
        baseLocalDataSourcel: gh<_i614.ThemeLocalDataSource>(),
      ),
    );
    gh.singleton<_i647.OutfitRepository>(
      () => _i215.OutfitRepositoryImpl(
        gh<_i743.OutfitRemoteDataSource>(),
        gh<_i626.OutfitLocalDataSource>(),
      ),
    );
    gh.factory<_i79.SuggestOutfitUseCase>(
      () => _i79.SuggestOutfitUseCase(gh<_i647.OutfitRepository>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i689.InjectableModule {}
