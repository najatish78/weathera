import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:weathera/core/data/model/error/error_model.dart';
import 'package:weathera/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/shared_prefrences_keys.dart';
import 'failures/http/http_failure.dart';

/// Prints exactly what the backend returned before it becomes a [Failure].
void _logRawServerResponse(DioException err, int statusCode, dynamic data) {
  if (!kDebugMode) return;
  log(
    '[ServerResponse] ${err.requestOptions.method} ${err.requestOptions.uri}\n'
    'status=$statusCode\n'
    'body=$data',
    name: 'ServerResponse',
  );
}

bool _isOpenWeatherRequest(RequestOptions options) =>
    options.uri.toString().startsWith(AppConstant.weatherBaseUrl);

HttpFailure _failureFromResponse(int statusCode, Response? response) {
  final data = response?.data;
  if (statusCode == HttpStatus.unauthorized) {
    return const UnauthorizedFailure();
  } else if (statusCode == HttpStatus.notFound) {
    return const NotFoundFailure();
  } else if (statusCode == HttpStatus.tooManyRequests) {
    return RateLimitedFailure(
      retryAfterSeconds: int.tryParse(
        (response?.headers.value('retry-after') ?? '').trim(),
      ),
    );
  } else if (statusCode >= 500) {
    return const ServerFailure();
  }
  final message = ErrorModel.fromResponse(data).displayMessage;
  if (statusCode == HttpStatus.badRequest) {
    return BadRequestFailure(message ?? '');
  }
  return message != null
      ? CustomFailure(message: message)
      : const UnknownFailure();
}

class AppInterceptors extends Interceptor {
  final SharedPreferences sharedPreferences;

  AppInterceptors(this.sharedPreferences);

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // OpenWeather: API key, units and response language on every call.
    if (_isOpenWeatherRequest(options)) {
      options.queryParameters['appid'] = AppConstant.openWeatherApiKey;
      options.queryParameters.putIfAbsent(
        'units',
        () => AppConstant.weatherUnits,
      );
      options.queryParameters.putIfAbsent(
        'lang',
        () =>
            sharedPreferences.getString(SharedPreferencesKeys.localCode) ??
            'en',
      );
    }

    options.sendTimeout = const Duration(seconds: 60);
    options.connectTimeout = const Duration(seconds: 60);
    options.receiveTimeout = const Duration(seconds: 60);

    handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.transformTimeout:
        throw const TimeOutFailure();
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        if (err.response == null) throw const NoInternetFailure();
        final statusCode = err.response?.statusCode ?? -1;
        _logRawServerResponse(err, statusCode, err.response?.data);
        throw _failureFromResponse(statusCode, err.response);
      case DioExceptionType.badCertificate:
        throw const BadRequestFailure("Bad Certificate");
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? -1;
        _logRawServerResponse(err, statusCode, err.response?.data);
        throw _failureFromResponse(statusCode, err.response);
      case DioExceptionType.cancel:
        throw const CancelRequestFailure();
    }
  }
}
