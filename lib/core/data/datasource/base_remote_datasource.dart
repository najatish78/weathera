import 'dart:developer';

import 'package:weathera/core/data/model/base_response_model.dart';
import 'package:weathera/core/utils/failures/http/http_failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../utils/failures/base_failure.dart';

abstract class BaseRemoteDataSource {
  @protected
  Future<BaseResponse<T>> get<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic) decoder,
  });

  @protected
  Future<T> getWithoutBaseResponse<T>({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic) decoder,
  });

  @protected
  Future<BaseResponse<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic) decoder,
  });

  @protected
  Future<T> postWithoutBaseResponse<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic) decoder,
  });
}

@lazySingleton
class BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  Dio dio;

  BaseRemoteDataSourceImpl({required this.dio});

  @override
  Future<BaseResponse<T>> get<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic p1) decoder,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: params);
      try {
        return BaseResponse<T>.fromJson(data: response.data, decoder: decoder);
      } catch (e) {
        throw const UnexpectedResponseFailure();
      }
    } on DioException catch (de) {
      throw _failureFrom(de);
    }
  }

  @override
  Future<T> getWithoutBaseResponse<T>({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic p1) decoder,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: headers != null ? Options(headers: headers) : null,
      );
      try {
        return decoder(response.data);
      } catch (e, stack) {
        if (kDebugMode) {
          log(
            'getWithoutBaseResponse decoder error: $e',
            name: 'ApiDebug',
            error: e,
            stackTrace: stack,
          );
        }
        throw const UnexpectedResponseFailure();
      }
    } on Failure {
      rethrow;
    } on DioException catch (de) {
      throw _failureFrom(de);
    }
  }

  @override
  Future<BaseResponse<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic p1) decoder,
  }) async {
    try {
      final response = await dio.post(
        url,
        queryParameters: params,
        data: body,
        options: headers != null ? Options(headers: headers) : null,
      );
      try {
        return BaseResponse<T>.fromJson(data: response.data, decoder: decoder);
      } catch (e) {
        throw const UnexpectedResponseFailure();
      }
    } on DioException catch (de) {
      throw _failureFrom(de);
    }
  }

  @override
  Future<T> postWithoutBaseResponse<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic p1) decoder,
  }) async {
    try {
      final response = await dio.post(
        url,
        queryParameters: params,
        data: body,
        options: headers != null ? Options(headers: headers) : null,
      );
      try {
        return decoder(response.data);
      } catch (e, stack) {
        if (kDebugMode) {
          log(
            'postWithoutBaseResponse decoder error: $e',
            name: 'ApiDebug',
            error: e,
            stackTrace: stack,
          );
        }
        throw const UnexpectedResponseFailure();
      }
    } on Failure {
      rethrow;
    } on DioException catch (de) {
      throw _failureFrom(de);
    }
  }

  /// The interceptor already classified the error into a [Failure].
  Failure _failureFrom(DioException de) =>
      de.error is Failure ? de.error as Failure : const UnknownFailure();
}
