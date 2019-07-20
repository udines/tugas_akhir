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
  Future<String> getCity();
}