import 'package:weathera/features/outfit/data/model/outfit_suggestion_model.dart';
import 'package:weathera/features/outfit/domain/params/suggest_outfit_params.dart';

abstract class OutfitRemoteDataSource {
  Future<OutfitSuggestionModel> suggestOutfit(SuggestOutfitParams params);
}
