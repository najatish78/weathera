import '../base_failure.dart';

abstract class HttpFailure extends Failure {
  const HttpFailure();
}

class ServerFailure extends HttpFailure {
  const ServerFailure();
}

class CustomFailure extends HttpFailure {
  final String message;

  const CustomFailure({required this.message});
}

/// HTTP 401 — the OpenWeather / AI API key is missing or invalid.
class UnauthorizedFailure extends HttpFailure {
  const UnauthorizedFailure();
}

/// HTTP 404 — e.g. OpenWeather could not find the requested city.
class NotFoundFailure extends HttpFailure {
  const NotFoundFailure();
}

class NoInternetFailure extends HttpFailure {
  const NoInternetFailure();
}

class TimeOutFailure extends HttpFailure {
  const TimeOutFailure();
}

class CancelRequestFailure extends HttpFailure {
  const CancelRequestFailure();
}

class UnknownFailure extends HttpFailure {
  const UnknownFailure();
}

class UnexpectedResponseFailure extends HttpFailure {
  const UnexpectedResponseFailure();
}

class BadRequestFailure extends HttpFailure {
  const BadRequestFailure(this.message);
  final String message;
}

/// HTTP 429 — the free plan's calls/minute (or calls/day) limit was hit.
class RateLimitedFailure extends HttpFailure {
  const RateLimitedFailure({this.retryAfterSeconds});

  final int? retryAfterSeconds;
}
