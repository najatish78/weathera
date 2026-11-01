import 'dart:math' as math;

import 'package:weathera/core/domain/usecase/usecase.dart';
import 'package:weathera/features/outfit/data/model/outfit_suggestion_model.dart';
import 'package:weathera/features/outfit/domain/params/outfit_weather_params.dart';
import 'package:weathera/features/outfit/domain/repository/outfit_repository.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';
import 'package:injectable/injectable.dart';

class SuggestOutfitUseCaseParams {
  final CurrentWeatherModel current;
  final ForecastModel forecast;

  const SuggestOutfitUseCaseParams({
    required this.current,
    required this.forecast,
  });
}

@injectable
class SuggestOutfitUseCase
    extends UseCase<OutfitSuggestionModel, SuggestOutfitUseCaseParams> {
  final OutfitRepository repository;

  SuggestOutfitUseCase(this.repository);

  /// The outfit has to work for the rest of the day, not just this moment.
  static const summaryHours = 12;

  @override
  Future<OutfitSuggestionModel> call(SuggestOutfitUseCaseParams params) =>
      repository.suggestOutfit(summarize(params.current, params.forecast));

  /// Range, worst rain chance and strongest wind over the next
  /// [summaryHours] of forecast; feels-like and condition are from now.
  /// Falls back to the current weather when the forecast is empty.
  static OutfitWeatherParams summarize(
    CurrentWeatherModel current,
    ForecastModel forecast,
  ) {
    final items = forecast.items.take((summaryHours / 3).ceil()).toList();
    if (items.isEmpty) {
      return OutfitWeatherParams(
        tempMin: current.tempMin,
        tempMax: current.tempMax,
        feelsLike: current.feelsLike,
        rainChance: 0,
        windSpeed: current.windSpeed,
        condition: current.condition.main,
      );
    }
    final temps = items.map((e) => e.temp);
    return OutfitWeatherParams(
      tempMin: temps.reduce(math.min),
      tempMax: temps.reduce(math.max),
      feelsLike: current.feelsLike,
      rainChance: (items.map((e) => e.rainChance).reduce(math.max) * 100)
          .round()
          .clamp(0, 100),
      windSpeed: items.map((e) => e.windSpeed).reduce(math.max),
      condition: current.condition.main,
    );
  }
}
