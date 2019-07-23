import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class RegisterViewContract {
  void onRegisterSuccess(User user);
  void onRegisterFailed();
  void showLoading(bool isLoading);
  void onGetAddressSuccess(String address);
  void onGetCitySuccess(String city);
  void onGetPostalCodeSuccess(String postalCode);
}

class RegisterPresenter {
  RegisterViewContract _view;
  UserRepository _repo;
  LocationRepository _locationRepo;

  RegisterPresenter(this._view) {
    _repo = Injector().userRepository;
    _locationRepo = Injector().locationRepository;
  }

  void registerUser(String email, String password, User user) {
    _view.showLoading(true);
    _repo.registerUser(email, password, user)
      .then((onValue) => {
        _view.onRegisterSuccess(user), 
        _view.showLoading(false)
      })
      .catchError((onError) => {
        _view.onRegisterFailed(),
        _view.showLoading(false)
      });
  }

  void saveUserInformation(User user) {
    _repo.saveUserInfo(user);
  }

  void _getUserCurrentLocation() {
    _locationRepo.getCurrentLocation()
      .then((location) {
        _getUserAddress(location.latitude, location.longitude);
        _getCity(location.latitude, location.longitude);
        _getPostalCode(location.latitude, location.longitude);
      });
  }

  void _getPostalCode(double lat, double long) {
    _locationRepo.getPostalCode(lat, long)
      .then((postalCode) {
        _view.onGetPostalCodeSuccess(postalCode);
    });
  }

  void _getUserAddress(double lat, double long) {
    _locationRepo.getAddress(lat, long)
      .then((address) {
        _view.onGetAddressSuccess(address);
      });
  }

  void _getCity(double lat, double long) {
    _locationRepo.getCityByCoordinate(lat, long)
      .then((city) {
        _view.onGetCitySuccess(city);
      });
  }

  void getInitialLocationInfo() {
    _locationRepo.getLocationPermission()
      .then((status) => _processPermission(status));
  }

  void _requestLocationPermission() {
    _locationRepo.requestLocationPermission()
      .then((response) => _processRequest(response));
  }

  void _processPermission(GeolocationStatus status) {
    if (status == GeolocationStatus.granted) {
      _getUserCurrentLocation();
    } else {
      _requestLocationPermission();
    }
  }

  void _processRequest(Map<PermissionGroup, PermissionStatus> response) {
    switch (response[PermissionGroup.location]) {
      case PermissionStatus.granted:
        _getUserCurrentLocation();
        break;
      default:
        break;
    }
  }
}