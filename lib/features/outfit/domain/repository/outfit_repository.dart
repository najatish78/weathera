import 'package:weathera/features/outfit/data/model/outfit_suggestion_model.dart';
import 'package:weathera/features/outfit/data/model/user_profile_model.dart';
import 'package:weathera/features/outfit/domain/params/outfit_weather_params.dart';

abstract class OutfitRepository {
  /// Dresses the saved profile for [weather], answered in the app language.
  Future<OutfitSuggestionModel> suggestOutfit(OutfitWeatherParams weather);

  UserProfileModel getProfile();

  Future<bool> saveProfile(UserProfileModel profile);
}
