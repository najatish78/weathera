import 'package:weathera/core/data/datasource/base_remote_datasource.dart';
import 'package:weathera/core/utils/constants.dart';
import 'package:weathera/features/weather/data/datasource/weather_remote_datasource.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';
import 'package:weathera/features/weather/domain/params/coordinates_params.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl({required super.dio});

  @override
  Future<CurrentWeatherModel> getCurrentWeather(CoordinatesParams params) {
    return getWithoutBaseResponse<CurrentWeatherModel>(
      url: '${AppConstant.weatherBaseUrl}/data/2.5/weather',
      params: params.toJson(),
      decoder: (json) =>
          CurrentWeatherModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ForecastModel> getForecast(CoordinatesParams params) {
    return getWithoutBaseResponse<ForecastModel>(
      url: '${AppConstant.weatherBaseUrl}/data/2.5/forecast',
      params: params.toJson(),
      decoder: (json) => ForecastModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
