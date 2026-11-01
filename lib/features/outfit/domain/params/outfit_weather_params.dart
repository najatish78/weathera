/// The weather the outfit is picked for (°C, m/s).
class OutfitWeatherParams {
  final double tempMin;
  final double tempMax;
  final double feelsLike;

  /// 0..100
  final int rainChance;
  final double windSpeed;

  /// OpenWeather `weather[0].main`: Clear, Clouds, Rain...
  final String condition;

  const OutfitWeatherParams({
    required this.tempMin,
    required this.tempMax,
    required this.feelsLike,
    required this.rainChance,
    required this.windSpeed,
    required this.condition,
  });

  Map<String, dynamic> toJson() => {
    'temp_min': tempMin,
    'temp_max': tempMax,
    'feels_like': feelsLike,
    'rain_chance': rainChance,
    'wind_speed': windSpeed,
    'condition': condition,
  };
}
