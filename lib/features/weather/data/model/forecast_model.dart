import 'current_weather_model.dart';
import 'weather_condition_model.dart';

/// GET /data/2.5/forecast — 5 days ahead in 3-hour steps (Free plan).
class ForecastModel {
  final List<ForecastItemModel> items;
  final int timezoneOffset;

  const ForecastModel({required this.items, required this.timezoneOffset});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final offset = ((json['city'] as Map?)?['timezone'] as num?)?.toInt() ?? 0;
    final list = json['list'] is List ? json['list'] as List : const [];
    return ForecastModel(
      items: list
          .whereType<Map>()
          .map((e) => ForecastItemModel.fromJson(e, offset))
          .toList(),
      timezoneOffset: offset,
    );
  }

  /// Highest chance of rain over the next [hours].
  double maxRainChance({int hours = 24}) {
    final steps = (hours / 3).ceil();
    return items
        .take(steps)
        .fold(
          0.0,
          (max, item) => item.rainChance > max ? item.rainChance : max,
        );
  }
}

class ForecastItemModel {
  /// Start of the 3-hour step, in the place's local time.
  final DateTime time;
  final double temp;
  final double feelsLike;

  /// Probability of precipitation, 0..1.
  final double rainChance;

  /// Rain volume for the 3 hours in mm.
  final double rainVolume;
  final double windSpeed;
  final WeatherConditionModel condition;

  const ForecastItemModel({
    required this.time,
    required this.temp,
    required this.feelsLike,
    required this.rainChance,
    required this.rainVolume,
    required this.windSpeed,
    required this.condition,
  });

  factory ForecastItemModel.fromJson(Map json, int offset) {
    final main = json['main'] as Map? ?? {};
    return ForecastItemModel(
      time: placeTime(json['dt'], offset),
      temp: _double(main['temp']),
      feelsLike: _double(main['feels_like']),
      rainChance: _double(json['pop']),
      rainVolume: _double((json['rain'] as Map?)?['3h']),
      windSpeed: _double((json['wind'] as Map?)?['speed']),
      condition: WeatherConditionModel.fromWeatherList(json['weather']),
    );
  }
}

double _double(dynamic value) => value is num ? value.toDouble() : 0;
