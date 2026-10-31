class AppConstant {
  /// OpenWeather (https://openweathermap.org/price) — Free plan endpoints.
  static const weatherBaseUrl = 'https://api.openweathermap.org';

  /// Keys are passed at build time, never committed:
  /// flutter run --dart-define=OPENWEATHER_API_KEY=xxx --dart-define=AI_API_KEY=xxx
  static const openWeatherApiKey = String.fromEnvironment(
    'OPENWEATHER_API_KEY',
  );
  static const aiApiKey = String.fromEnvironment('AI_API_KEY');

  /// `metric` → °C, m/s.
  static const weatherUnits = 'metric';

  static const appVersion = 1;

  static const listMaxResult = 20;
}
