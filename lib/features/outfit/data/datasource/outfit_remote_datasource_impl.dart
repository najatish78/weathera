import 'package:weathera/core/data/datasource/base_remote_datasource.dart';
import 'package:weathera/core/utils/constants.dart';
import 'package:weathera/features/outfit/data/datasource/outfit_remote_datasource.dart';
import 'package:weathera/features/outfit/data/model/outfit_suggestion_model.dart';
import 'package:weathera/features/outfit/domain/params/suggest_outfit_params.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: OutfitRemoteDataSource)
class OutfitRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements OutfitRemoteDataSource {
  OutfitRemoteDataSourceImpl({required super.dio});

  @override
  Future<OutfitSuggestionModel> suggestOutfit(SuggestOutfitParams params) {
    return postWithoutBaseResponse<OutfitSuggestionModel>(
      url: '${AppConstant.aiBaseUrl}/suggest-outfit',
      body: params.toJson(),
      decoder: (json) =>
          OutfitSuggestionModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
