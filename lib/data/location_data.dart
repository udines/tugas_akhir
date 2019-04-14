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
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}