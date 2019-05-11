import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'location_data.dart';

class MockLocationRepository implements LocationRepository {
  @override
  Future<LatLng> getCurrentLocation() {
    return new Future.value(
      new LatLng(
        latitude: -7.821251, 
        longitude: 110.417633
      )
    );
  }

  @override
  Future<GeolocationStatus> getLocationPermission() {
    return Future.value(
      GeolocationStatus.denied
    );
  }

  @override
  Future<Map<PermissionGroup, PermissionStatus>> requestLocationPermission() {
    var map = {PermissionGroup.location: PermissionStatus.granted};
    return Future.value(
      map
    );
  }

  @override
  Future<String> getAddress(double latitude, double longitude) {
    return Future.value(
      "Mock: Jalan Sukabirus No.418"
    );
  }
}

