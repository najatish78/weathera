import 'package:weathera/core/data/model/error/error_model.dart';

/// Envelope `{ result, success, error }`. OpenWeather does not wrap its
/// responses, so its datasources use the `*WithoutBaseResponse` calls.
class BaseResponse<T> {
  final T? data;
  final bool? success;
  final ErrorModel? error;

  factory BaseResponse.fromJson({
    required dynamic data,
    T Function(dynamic json)? decoder,
  }) {
    return BaseResponse(
      data: decoder?.call(data['result'] ?? data ?? {}),
      success: (data['success']) ?? false,
      error: data['error'] is Map
          ? ErrorModel.fromJson(Map<String, dynamic>.from(data['error']))
          : null,
    );
  }

  @override
  String toString() {
    return 'data: $data';
  }

  BaseResponse({
    required this.data,
    required this.success,
    required this.error,
  });
}
