import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LatLng {
  double latitude;
  double longitude;

  LatLng({
    this.latitude,
    this.longitude
  });
}

abstract class LocationRepository {
  Future<LatLng> getCurrentLocation();
  Future<GeolocationStatus> getLocationPermission();
  Future<Map<PermissionGroup, PermissionStatus>> requestLocationPermission();
  Future<String> getAddress(double latitude, double longitude);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}