import 'package:bloc/bloc.dart';
import 'package:weathera/core/services/location_helper.dart';
import 'package:weathera/core/utils/failures/base_failure.dart';
import 'package:weathera/core/utils/failures/location/location_failure.dart';
import 'package:weathera/di/injection.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';
import 'package:weathera/features/weather/domain/params/coordinates_params.dart';
import 'package:weathera/features/weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:weathera/features/weather/domain/usecase/get_forecast_usecase.dart';

part 'current_weather_state.dart';

/// Weather at the device location: current conditions plus the forecast.
class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit({required this.lang})
    : super(CurrentWeatherState.initial());

  final String lang;
  final _locationHelper = getIt<LocationHelper>();
  final _getCurrentWeather = getIt<GetCurrentWeatherUseCase>();
  final _getForecast = getIt<GetForecastUseCase>();

  Future<void> load() async {
    emit(state.copyWith(status: CurrentWeatherStatus.loading));
    try {
      final data = await _fetch();
      if (!isClosed) {
        emit(state.copyWith(status: CurrentWeatherStatus.success, data: data));
      }
    } on Failure catch (e) {
      if (!isClosed) {
        emit(state.copyWith(status: CurrentWeatherStatus.error, failure: e));
      }
    }
  }

  /// Pull to refresh: keeps the current numbers on screen while loading and
  /// only shows the error when there is nothing to show.
  Future<void> refresh() async {
    try {
      final data = await _fetch();
      if (!isClosed) {
        emit(state.copyWith(status: CurrentWeatherStatus.success, data: data));
      }
    } on Failure catch (e) {
      if (!isClosed && state.data == null) {
        emit(state.copyWith(status: CurrentWeatherStatus.error, failure: e));
      }
    }
  }

  /// Permanently denied: the only way out is the app settings.
  Future<void> openSettings() => _locationHelper.openAppSettings();

  Future<CurrentWeatherData> _fetch() async {
    final position = await _locationHelper.getCurrentPosition();
    final params = CoordinatesParams(
      lat: position.latitude,
      lon: position.longitude,
      lang: lang,
    );
    // Both calls run in parallel; the first Failure is rethrown as is.
    final results = await Future.wait([
      _getCurrentWeather(params),
      _getForecast(params),
    ], eagerError: true);
    return CurrentWeatherData(
      current: results[0] as CurrentWeatherModel,
      forecast: results[1] as ForecastModel,
    );
  }
}
