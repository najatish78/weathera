import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../failures/base_failure.dart';
import '../failures/http/http_failure.dart';
import '../failures/local_storage/local_storage_failure.dart';
import '../failures/location/location_failure.dart';
import 'http_failure_parser/http_failure_parser.dart';

class FailureParser {
  static String mapFailureToString({
    required Failure failure,
    required BuildContext context,
  }) {
    if (failure is HttpFailure) {
      return HttpFailureParser.mapHttpFailureToErrorMessage(failure);
    } else if (failure is LocationServiceDisabledFailure) {
      return tr("failures.location.service_disabled");
    } else if (failure is LocationPermissionDeniedForeverFailure) {
      return tr("failures.location.denied_forever");
    } else if (failure is LocationPermissionDeniedFailure) {
      return tr("failures.location.denied");
    } else if (failure is LocationUnavailableFailure) {
      return tr("failures.location.unavailable");
    } else if (failure is LocalStorageFailure) {
      return tr("failures.local_storage");
    } else {
      return tr("failures.unknown");
    }
  }
}
