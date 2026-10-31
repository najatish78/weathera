import 'package:weathera/core/domain/usecase/usecase.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';
import 'package:weathera/features/weather/domain/params/coordinates_params.dart';
import 'package:weathera/features/weather/domain/repository/weather_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetForecastUseCase extends UseCase<ForecastModel, CoordinatesParams> {
  final WeatherRepository repository;

  GetForecastUseCase(this.repository);

  @override
  Future<ForecastModel> call(CoordinatesParams params) =>
      repository.getForecast(params);
}
