import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathera/core/data/datasource/shared_prefrences_keys.dart';
import 'package:weathera/features/outfit/data/model/user_profile_model.dart';

abstract class OutfitLocalDataSource {
  /// The saved profile, or [UserProfileModel.defaults] when there is none.
  UserProfileModel getProfile();

  Future<bool> saveProfile(UserProfileModel profile);

  /// Language for the AI answer: `ar` or `en`.
  String getLang();
}

@LazySingleton(as: OutfitLocalDataSource)
class OutfitLocalDataSourceImpl implements OutfitLocalDataSource {
  final SharedPreferences sharedPreferences;

  OutfitLocalDataSourceImpl(this.sharedPreferences);

  @override
  UserProfileModel getProfile() {
    final raw = sharedPreferences.getString(SharedPreferencesKeys.userProfile);
    if (raw == null) return UserProfileModel.defaults;
    try {
      return UserProfileModel.fromJson(json.decode(raw));
    } catch (_) {
      return UserProfileModel.defaults;
    }
  }

  @override
  Future<bool> saveProfile(UserProfileModel profile) => sharedPreferences
      .setString(SharedPreferencesKeys.userProfile, json.encode(profile));

  @override
  String getLang() =>
      sharedPreferences.getString(SharedPreferencesKeys.localCode) == 'ar'
      ? 'ar'
      : 'en';
}
