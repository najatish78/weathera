import 'weather_condition_model.dart';

/// GET /data/2.5/weather — weather right now at a place.
class CurrentWeatherModel {
  final String cityName;
  final String country;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int clouds;

  /// Rain volume of the last hour in mm (0 when it isn't raining).
  final double rainLastHour;
  final WeatherConditionModel condition;

  /// All times are in the place's local time (UTC + [timezoneOffset]).
  final DateTime time;
  final DateTime sunrise;
  final DateTime sunset;
  final int timezoneOffset;

  const CurrentWeatherModel({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.clouds,
    required this.rainLastHour,
    required this.condition,
    required this.time,
    required this.sunrise,
    required this.sunset,
    required this.timezoneOffset,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map? ?? {};
    final sys = json['sys'] as Map? ?? {};
    final offset = (json['timezone'] as num?)?.toInt() ?? 0;
    return CurrentWeatherModel(
      cityName: json['name']?.toString() ?? '',
      country: sys['country']?.toString() ?? '',
      temp: _double(main['temp']),
      feelsLike: _double(main['feels_like']),
      tempMin: _double(main['temp_min']),
      tempMax: _double(main['temp_max']),
      humidity: _double(main['humidity']).toInt(),
      windSpeed: _double((json['wind'] as Map?)?['speed']),
      clouds: _double((json['clouds'] as Map?)?['all']).toInt(),
      rainLastHour: _double((json['rain'] as Map?)?['1h']),
      condition: WeatherConditionModel.fromWeatherList(json['weather']),
      time: placeTime(json['dt'], offset),
      sunrise: placeTime(sys['sunrise'], offset),
      sunset: placeTime(sys['sunset'], offset),
      timezoneOffset: offset,
    );
  }
}

double _double(dynamic value) => value is num ? value.toDouble() : 0;

/// Unix seconds → wall-clock time at the place (not the phone's time zone).
DateTime placeTime(dynamic unixSeconds, int offsetSeconds) {
  final seconds = unixSeconds is num ? unixSeconds.toInt() : 0;
  return DateTime.fromMillisecondsSinceEpoch(
    (seconds + offsetSeconds) * 1000,
    isUtc: true,
  );
}
