import 'package:weathera/features/outfit/data/model/user_profile_model.dart';
import 'package:weathera/features/outfit/domain/params/outfit_weather_params.dart';

/// Body of POST /suggest-outfit.
class SuggestOutfitParams {
  final OutfitWeatherParams weather;
  final UserProfileModel profile;

  /// `ar` or `en`.
  final String lang;

  const SuggestOutfitParams({
    required this.weather,
    required this.profile,
    required this.lang,
  });

  Map<String, dynamic> toJson() => {
    'weather': weather.toJson(),
    'profile': profile.toJson(),
    'lang': lang,
  };
}
