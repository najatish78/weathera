import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../utils/failures/location/location_failure.dart';

@lazySingleton
class LocationHelper {
  /// Current device position. Asks for the permission when needed and throws
  /// a [LocationFailure] when the location can't be read.
  Future<Position> getCurrentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationServiceDisabledFailure();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationPermissionDeniedForeverFailure();
    }
    if (permission == LocationPermission.denied) {
      throw const LocationPermissionDeniedFailure();
    }

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } catch (_) {
      throw const LocationUnavailableFailure();
    }
  }

  Future<bool> openAppSettings() => Geolocator.openAppSettings();
}
