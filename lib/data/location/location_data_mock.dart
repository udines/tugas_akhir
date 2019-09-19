import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:tugas_akhir/data/location/location_data.dart';

class MockLocationRepository implements LocationRepository {
  @override
  Future<LatLng> getCurrentLocation() {
    return Future.value(LatLng(
      latitude: -7.819144,
      longitude: 110.407533)
    );
  }

  @override
  Future<GeolocationStatus> getLocationPermission() {
    return Future.value(
      GeolocationStatus.granted
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

  @override
  Future<String> getCity() {
    return Future.value('Bandung');
  }

  @override
  Future<String> getCityByCoordinate(double latitude, double longitude) {
    return Future.value('Bandung');
  }

  @override
  Future<String> getPostalCode(double latitude, double longitude) {
    return Future.value('52585');
  }

  @override
  Future<String> getProvince() {
    return Future.value('Jawa Barat');
  }

  @override
  Future<String> getCurrentAddress() {
    return Future.value(
        "Mock: Jalan Sukabirus No.418"
    );
  }
}

