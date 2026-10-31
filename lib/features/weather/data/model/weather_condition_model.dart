/// One entry of OpenWeather's `weather[]` array.
class WeatherConditionModel {
  /// Condition code: 2xx thunderstorm, 3xx drizzle, 5xx rain, 6xx snow,
  /// 7xx atmosphere (fog, dust...), 800 clear, 80x clouds.
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherConditionModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherConditionModel.fromWeatherList(dynamic list) {
    if (list is List && list.isNotEmpty && list.first is Map) {
      final json = list.first as Map;
      return WeatherConditionModel(
        id: (json['id'] as num?)?.toInt() ?? 0,
        main: json['main']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        icon: json['icon']?.toString() ?? '01d',
      );
    }
    return const WeatherConditionModel(
      id: 0,
      main: '',
      description: '',
      icon: '01d',
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@4x.png';

  bool get isRainy => id >= 200 && id < 600;

  bool get isSnowy => id >= 600 && id < 700;

  bool get isClear => id == 800;
}
