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
}

