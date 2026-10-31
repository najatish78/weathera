import 'package:weathera/features/weather/data/datasource/weather_remote_datasource.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';
import 'package:weathera/features/weather/domain/params/coordinates_params.dart';
import 'package:weathera/features/weather/domain/repository/weather_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<CurrentWeatherModel> getCurrentWeather(CoordinatesParams params) =>
      remoteDataSource.getCurrentWeather(params);

  @override
  Future<ForecastModel> getForecast(CoordinatesParams params) =>
      remoteDataSource.getForecast(params);
}
