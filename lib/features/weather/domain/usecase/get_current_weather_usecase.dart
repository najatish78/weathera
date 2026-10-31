import 'package:weathera/core/domain/usecase/usecase.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/domain/params/coordinates_params.dart';
import 'package:weathera/features/weather/domain/repository/weather_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentWeatherUseCase
    extends UseCase<CurrentWeatherModel, CoordinatesParams> {
  final WeatherRepository repository;

  GetCurrentWeatherUseCase(this.repository);

  @override
  Future<CurrentWeatherModel> call(CoordinatesParams params) =>
      repository.getCurrentWeather(params);
}
