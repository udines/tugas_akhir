import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/src/permission_enums.dart';
import 'location_data.dart';

class ProdLocationRepository implements LocationRepository {
  @override
  Future<LatLng> getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(latitude: position.latitude, longitude: position.longitude);
  }

  @override
  Future<GeolocationStatus> getLocationPermission() {
    Future<GeolocationStatus> geolocationStatus  = Geolocator().checkGeolocationPermissionStatus();
    return geolocationStatus;
  }

  @override
  Future<Map<PermissionGroup, PermissionStatus>> requestLocationPermission() {
    Future<Map<PermissionGroup, PermissionStatus>> response =  PermissionHandler()
        .requestPermissions([PermissionGroup.location]);
    return response;
  }
}