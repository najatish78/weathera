import 'package:flutter_test/flutter_test.dart';
import 'package:weathera/features/outfit/domain/usecase/suggest_outfit_usecase.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';

const _clouds = {'id': 803, 'main': 'Clouds', 'description': 'broken clouds'};
const _rain = {'id': 500, 'main': 'Rain', 'description': 'light rain'};

final _current = CurrentWeatherModel.fromJson({
  'main': {'temp': 18, 'feels_like': 16.5, 'temp_min': 17, 'temp_max': 19},
  'wind': {'speed': 3},
  'weather': [_clouds],
});

Map<String, dynamic> _step(num temp, num pop, num wind) => {
  'main': {'temp': temp},
  'pop': pop,
  'wind': {'speed': wind},
  'weather': [_rain],
};

void main() {
  test('summarizes the next 12 hours (4 steps) of forecast', () {
    final forecast = ForecastModel.fromJson({
      'list': [
        _step(20, 0.1, 4),
        _step(14, 0.62, 7.5),
        _step(11, 0.3, 2),
        _step(12, 0, 5),
        // Beyond 12h: ignored.
        _step(2, 1, 20),
      ],
    });

    final weather = SuggestOutfitUseCase.summarize(_current, forecast).toJson();

    expect(weather, {
      'temp_min': 11,
      'temp_max': 20,
      'feels_like': 16.5,
      'rain_chance': 62,
      'wind_speed': 7.5,
      'condition': 'Clouds',
    });
  });

  test('falls back to the current weather without a forecast', () {
    final forecast = ForecastModel.fromJson({'list': []});

    final weather = SuggestOutfitUseCase.summarize(_current, forecast).toJson();

    expect(weather, {
      'temp_min': 17,
      'temp_max': 19,
      'feels_like': 16.5,
      'rain_chance': 0,
      'wind_speed': 3,
      'condition': 'Clouds',
    });
  });
}
