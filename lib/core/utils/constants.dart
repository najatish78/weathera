class AppConstant {
  /// OpenWeather (https://openweathermap.org/price) — Free plan endpoints.
  static const weatherBaseUrl = 'https://api.openweathermap.org';

  /// Keys live in the git-ignored `env.json` (see `env.example.json`):
  /// flutter run --dart-define-from-file=env.json
  static const openWeatherApiKey = String.fromEnvironment(
    'OPENWEATHER_API_KEY',
  );
  static const aiApiKey = String.fromEnvironment('AI_API_KEY');

  /// `metric` → °C, m/s.
  static const weatherUnits = 'metric';

  static const appVersion = 1;

  static const listMaxResult = 20;
}
