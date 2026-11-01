import 'package:weathera/features/outfit/data/datasource/outfit_local_datasource.dart';
import 'package:weathera/features/outfit/data/datasource/outfit_remote_datasource.dart';
import 'package:weathera/features/outfit/data/model/outfit_suggestion_model.dart';
import 'package:weathera/features/outfit/data/model/user_profile_model.dart';
import 'package:weathera/features/outfit/domain/params/outfit_weather_params.dart';
import 'package:weathera/features/outfit/domain/params/suggest_outfit_params.dart';
import 'package:weathera/features/outfit/domain/repository/outfit_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: OutfitRepository)
class OutfitRepositoryImpl implements OutfitRepository {
  final OutfitRemoteDataSource remoteDataSource;
  final OutfitLocalDataSource localDataSource;

  OutfitRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<OutfitSuggestionModel> suggestOutfit(OutfitWeatherParams weather) =>
      remoteDataSource.suggestOutfit(
        SuggestOutfitParams(
          weather: weather,
          profile: localDataSource.getProfile(),
          lang: localDataSource.getLang(),
        ),
      );

  @override
  UserProfileModel getProfile() => localDataSource.getProfile();

  @override
  Future<bool> saveProfile(UserProfileModel profile) =>
      localDataSource.saveProfile(profile);
}
