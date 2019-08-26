import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/location/location_data.dart';

class ProdLocationRepository implements LocationRepository {
  @override
  Future<LatLng> getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(latitude: position.latitude, longitude: position.longitude);
  }

  @override
  Future<GeolocationStatus> getLocationPermission() async {
    return await Geolocator().checkGeolocationPermissionStatus();
  }

  @override
  Future<Map<PermissionGroup, PermissionStatus>> requestLocationPermission() async {
    return await  PermissionHandler().requestPermissions([PermissionGroup.location]);
  }

  @override
  Future<String> getAddress(double latitude, double longitude) async {
    final coordinates = Coordinates(latitude, longitude);
    final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    return first.addressLine;
  }

  @override
  Future<String> getCity() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
    .placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemark.isEmpty) {
      return '';
    } else {
      return placemark[0].subAdministrativeArea;
    }
  }

  @override
  Future<String> getCityByCoordinate(double latitude, double longitude) async {
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(latitude, longitude);
    if (placemark.isEmpty) {
      return '';
    } else {
      return placemark[0].subAdministrativeArea;
    }
  }

  @override
  Future<String> getPostalCode(double latitude, double longitude) async {
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(latitude, longitude);
    if (placemark.isEmpty) {
      return '';
    } else {
      return placemark[0].postalCode;
    }
  }

  @override
  Future<String> getProvince() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
    .placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemark.isEmpty) {
      return '';
    } else {
      return placemark[0].administrativeArea;
    }
  }

  @override
  Future<String> getCurrentAddress() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = Coordinates(position.latitude, position.longitude);
    final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    return first.addressLine;
  }
}