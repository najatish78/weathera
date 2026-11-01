import 'package:bloc/bloc.dart';
import 'package:weathera/core/utils/failures/base_failure.dart';
import 'package:weathera/di/injection.dart';
import 'package:weathera/features/outfit/data/model/outfit_suggestion_model.dart';
import 'package:weathera/features/outfit/domain/usecase/suggest_outfit_usecase.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';

part 'outfit_state.dart';

/// AI outfit suggestion for the weather on the home screen.
class OutfitCubit extends Cubit<OutfitState> {
  OutfitCubit() : super(OutfitState.initial());

  final _suggestOutfit = getIt<SuggestOutfitUseCase>();

  SuggestOutfitUseCaseParams? _lastParams;

  /// Keeps the previous suggestion on screen while the new one loads, and
  /// only shows the error when there is nothing to show.
  Future<void> suggest({
    required CurrentWeatherModel current,
    required ForecastModel forecast,
  }) async {
    final params = SuggestOutfitUseCaseParams(
      current: current,
      forecast: forecast,
    );
    _lastParams = params;
    emit(state.copyWith(status: OutfitStatus.loading));
    try {
      final data = await _suggestOutfit(params);
      if (!isClosed && identical(params, _lastParams)) {
        emit(state.copyWith(status: OutfitStatus.success, data: data));
      }
    } on Failure catch (e) {
      if (!isClosed && identical(params, _lastParams)) {
        emit(state.copyWith(status: OutfitStatus.error, failure: e));
      }
    }
  }

  Future<void> retry() async {
    final params = _lastParams;
    if (params == null) return;
    await suggest(current: params.current, forecast: params.forecast);
  }
}
