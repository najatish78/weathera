import 'package:weathera/core/utils/failures/http/http_failure.dart';
import 'package:easy_localization/easy_localization.dart';

class HttpFailureParser {
  static String mapHttpFailureToErrorMessage(HttpFailure failure) {
    if (failure is NoInternetFailure) {
      return tr("failures.no_internet");
    } else if (failure is UnauthorizedFailure) {
      return tr("failures.invalid_api_key");
    } else if (failure is NotFoundFailure) {
      return tr("failures.not_found");
    } else if (failure is ServerFailure) {
      return tr("failures.server_error");
    } else if (failure is TimeOutFailure) {
      return tr("failures.time_out");
    } else if (failure is UnexpectedResponseFailure) {
      return tr("failures.unexpectedResponse");
    } else if (failure is RateLimitedFailure) {
      return tr("failures.rate_limited");
    } else if (failure is CustomFailure) {
      return failure.message;
    } else if (failure is BadRequestFailure) {
      final msg = failure.message.trim();
      return msg.isNotEmpty ? msg : tr("failures.some_thing_wrong");
    } else {
      return tr("failures.some_thing_wrong");
    }
  }
}
