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
  void onPermissionDenied();
  void onCredentialsInvalid();
}

class RegisterPresenter {
  RegisterViewContract _view;
  UserRepository _repo;
  LocationRepository _locationRepo;

  RegisterPresenter(this._view) {
    _repo = Injector().userRepository;
    _locationRepo = Injector().locationRepository;
  }

  testConstructor(RegisterViewContract view, UserRepository userRepo, LocationRepository locationRepo) {
    _view = view;
    _repo = userRepo;
    _locationRepo = locationRepo;
  }

  registerUser(String email, String password, User user) async {
    if (checkCredentials(email, password)) {
      _view.showLoading(true);
      try {
        await _repo.registerUser(email, password, user);
        _view.showLoading(false);
        _view.onRegisterSuccess(user);
      } catch(e) {
        _view.showLoading(false);
        _view.onRegisterFailed();
      }
    } else {
      _view.onCredentialsInvalid();
    }
  }

  bool checkCredentials(String email, String password) {
    return (validateEmail(email) && validatePassword(password));
  }

  bool validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }

  saveUserInformation(User user) {
    _repo.saveUserInfo(user);
  }

  getUserCurrentLocation() async {
    try {
      final location = await _locationRepo.getCurrentLocation();
      getUserAddress(location.latitude, location.longitude);
      getCity(location.latitude, location.longitude);
      getPostalCode(location.latitude, location.longitude);
    } catch(e) {

    }
  }

  getPostalCode(double lat, double long) async {
    try {
      final postalCode = await _locationRepo.getPostalCode(lat, long);
      _view.onGetPostalCodeSuccess(postalCode);
    } catch(e) {

    }
  }

  getUserAddress(double lat, double long) async {
    try {
      final address = await _locationRepo.getAddress(lat, long);
      _view.onGetAddressSuccess(address);
    } catch(e) {

    }
  }

  getCity(double lat, double long) async {
    try {
      final city = await _locationRepo.getCityByCoordinate(lat, long);
      _view.onGetCitySuccess(city);
    } catch(e) {
      _view.onGetCitySuccess('');
    }
  }

  getInitialLocationInfo() async {
    try {
      final status = await _locationRepo.getLocationPermission();
      if (status == GeolocationStatus.granted) {
        getUserCurrentLocation();
      } else {
        requestLocationPermission();
      }
    } catch(e) {

    }
  }

  requestLocationPermission() async {
    try {
      final response = await _locationRepo.requestLocationPermission();
      switch (response[PermissionGroup.location]) {
        case PermissionStatus.granted:
          getUserCurrentLocation();
          break;
        default:
          _view.onPermissionDenied();
          break;
      }
    } catch(e) {
      _view.onPermissionDenied();
    }
  }
}