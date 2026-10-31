# Weathera ☀️🌧️

Weathera is a Flutter mobile app that turns the weather forecast into practical advice.
Pick your current location or a city you're traveling to, choose a date, and Weathera
shows the forecast — temperature, rain probability, sunshine, wind — then uses AI to
suggest what to wear, and whether to bring an umbrella or put on boots.

## Features
- 📍 Weather for your current location or any city
- 📅 Forecast for a chosen date and time
- 🌧️ Rain probability, temperature and conditions (OpenWeather API)
- 👕 AI outfit suggestions based on the weather and your profile
- ☂️ Umbrella / boots / sunscreen reminders
- 🌍 Arabic & English, light & dark themes

## Tech Stack
- Flutter · Dart
- Clean Architecture (data / domain / presentation)
- BLoC / Cubit · get_it + injectable
- Dio · go_router · easy_localization · flutter_screenutil
- OpenWeather API · AI API

## Run
API keys live in a local `env.json` that is git-ignored and never committed:

```bash
cp env.example.json env.json   # then put your keys in env.json
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define-from-file=env.json
```

In Android Studio the shared `main.dart` run configuration (`.run/`) already passes `--dart-define-from-file=env.json`.
