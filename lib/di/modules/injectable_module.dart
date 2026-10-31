import 'dart:async';

import 'package:weathera/core/utils/dio_intercepter.dart';
import 'package:weathera/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

void _prettyDioLogPrint(Object object) {
  if (!kDebugMode) return;
  debugPrint(object.toString());
}

@module
abstract class InjectableModule {
  @lazySingleton
  InternetConnectionChecker createConnectionChecker() =>
      InternetConnectionChecker.createInstance();

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        followRedirects: true,
        headers: {'Accept': 'application/json'},
        validateStatus: (statusCode) =>
            statusCode != null && 200 <= statusCode && statusCode < 300,
      ),
    );

    // Api keys/lang before logger so PrettyDioLogger sees final params.
    dio.interceptors.add(AppInterceptors(getIt<SharedPreferences>()));

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: false,
        maxWidth: 2000,
        logPrint: _prettyDioLogPrint,
      ),
    );

    return dio;
  }
}
