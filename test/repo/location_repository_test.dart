import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/data/location/location_data_mock.dart';
import 'package:tugas_akhir/data/location/location_data_prod.dart';

class LocationMock extends MockLocationRepository {}
class LocationProd extends ProdLocationRepository {}

main () {
  group('mock location test', () {
    var mock = LocationMock();
    test('get current location', () async {
      var result = await mock.getCurrentLocation();
      expect(result, isInstanceOf<LatLng>());
    });

    test('get location permission', () async {
      var result = await mock.getLocationPermission();
      expect(result, isInstanceOf<GeolocationStatus>());
    });

    test('request location permission', () async {
      var result = await mock.requestLocationPermission();
      expect(result, isInstanceOf<Map<PermissionGroup, PermissionStatus>>());
    });

    test('get address by coordinate', () async {
      var result = await mock.getAddress(any, any);
      expect(result, isInstanceOf<String>());
    });

    test('get current city', () async {
      var result = await mock.getCity();
      expect(result, isInstanceOf<String>());
    });

    test('get city by coordinate', () async {
      var result = await mock.getCityByCoordinate(any, any);
      expect(result, isInstanceOf<String>());
    });

    test('get postal code', () async {
      var result = await mock.getPostalCode(any, any);
      expect(result, isInstanceOf<String>());
    });

    test('get current province', () async {
      var result = await mock.getProvince();
      expect(result, isInstanceOf<String>());
    });

    test('get current address', () async {
      var result = await mock.getCurrentAddress();
      expect(result, isInstanceOf<String>());
    });
  });
}