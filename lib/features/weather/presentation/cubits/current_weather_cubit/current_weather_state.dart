part of 'current_weather_cubit.dart';

enum CurrentWeatherStatus { initial, loading, error, success }

class CurrentWeatherData {
  final CurrentWeatherModel current;
  final ForecastModel forecast;

  const CurrentWeatherData({required this.current, required this.forecast});
}

class CurrentWeatherState {
  final CurrentWeatherStatus status;
  final CurrentWeatherData? data;
  final Failure? failure;

  CurrentWeatherState._({required this.status, this.data, this.failure});

  CurrentWeatherState.initial()
    : status = CurrentWeatherStatus.initial,
      data = null,
      failure = null;

  bool get needsAppSettings =>
      failure is LocationPermissionDeniedForeverFailure;

  CurrentWeatherState copyWith({
    CurrentWeatherStatus? status,
    CurrentWeatherData? data,
    Failure? failure,
  }) {
    return CurrentWeatherState._(
      status: status ?? this.status,
      data: data ?? this.data,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() {
    return 'CurrentWeatherState {status: $status}';
  }
}
