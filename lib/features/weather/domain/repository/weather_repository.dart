import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';
import 'package:weathera/features/weather/domain/params/coordinates_params.dart';

abstract class WeatherRepository {
  Future<CurrentWeatherModel> getCurrentWeather(CoordinatesParams params);

  Future<ForecastModel> getForecast(CoordinatesParams params);
}
