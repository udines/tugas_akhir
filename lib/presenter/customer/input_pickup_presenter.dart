import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class InputPickupViewContract {
  void onGetCurrentUserLocationComplete(double latitude, double longitude);
  void onGetCurrentUserLocationError(String errorMessage);
  void onGetAddressComplete(String address);
  void onGetAddressError(String errorMessage);
}

class InputPickupPresenter {
  InputPickupViewContract _view;
  LocationRepository _locationRepo;

  InputPickupPresenter(this._view) {
    _locationRepo = new Injector().locationRepository;
  }

  void getUserCurrentLocation() {
    _locationRepo.getCurrentLocation()
        .then((location) => _view.onGetCurrentUserLocationComplete(
          location.latitude, 
          location.longitude))
        .catchError((onError) => _view.onGetCurrentUserLocationError(onError.toString()));
  }

  void getAddress(double latitude, double longitude) {
    _locationRepo.getAddress(latitude, longitude)
        .then((address) => _view.onGetAddressComplete(address))
        .catchError((onError) => _view.onGetAddressError(onError.toString()));
  }
}