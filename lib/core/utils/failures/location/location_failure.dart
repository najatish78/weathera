import '../base_failure.dart';

abstract class LocationFailure extends Failure {
  const LocationFailure();
}

/// GPS / location services are switched off on the device.
class LocationServiceDisabledFailure extends LocationFailure {
  const LocationServiceDisabledFailure();
}

/// The user refused the permission; asking again is still possible.
class LocationPermissionDeniedFailure extends LocationFailure {
  const LocationPermissionDeniedFailure();
}

/// The user refused permanently; only the app settings can change it.
class LocationPermissionDeniedForeverFailure extends LocationFailure {
  const LocationPermissionDeniedForeverFailure();
}

/// The position couldn't be read in time (no GPS fix, simulator without a
/// location...).
class LocationUnavailableFailure extends LocationFailure {
  const LocationUnavailableFailure();
}
