import 'package:geolocator/geolocator.dart';
import 'location_data.dart';

class ProdLocationRepository implements LocationRepository {
  @override
  Future<LatLng> getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return LatLng(latitude: position.latitude, longitude: position.longitude);
  }
}