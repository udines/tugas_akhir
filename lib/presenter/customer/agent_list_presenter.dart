import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AgentListViewContract {
  void onLoadAgentComplete(List<Agent> agents);
  void onLoadAgentError();
  void onGetCityComplete(String city);
  void onLocationPermissionGranted();
  void onLocationPermissionDenied();
  void onGetCurrentUserLocationComplete(double latitude, double longitude);
  void onGetCurrentUserLocationError(String errorMessage);
}

class AgentListPresenter {
  AgentListViewContract _view;
  AgentRepository _repository;
  LocationRepository _locationRepo;

  AgentListPresenter(this._view) {
    _repository = new Injector().agentRepository;
    _locationRepo = Injector().locationRepository;
  }
  
  void fetchAgentsNearby(double latitude, double longitude, double radius) {
    _repository.fetchAgentsNearby(latitude, longitude, radius)
        .then((agents) => _view.onLoadAgentComplete(agents))
        .catchError((onError) => _view.onLoadAgentError());
  }

  void getUserCurrentLocation() {
    _locationRepo.getCurrentLocation()
        .then((location) => _view.onGetCurrentUserLocationComplete(
        location.latitude,
        location.longitude))
        .catchError((onError) => _view.onGetCurrentUserLocationError(onError.toString()));
  }

  void checkLocationPermission() {
    _locationRepo.getLocationPermission()
        .then((status) => _processPermission(status));
  }

  void requestLocationPermission() {
    _locationRepo.requestLocationPermission()
        .then((response) => _processRequest(response));
  }

  void _processPermission(GeolocationStatus status) {
    if (status == GeolocationStatus.granted) {
      _view.onLocationPermissionGranted();
    } else {
      _view.onLocationPermissionDenied();
    }
  }

  void _processRequest(Map<PermissionGroup, PermissionStatus> response) {
    switch (response[PermissionGroup.location]) {
      case PermissionStatus.granted:
        _view.onLocationPermissionGranted();
        break;
      default:
        _view.onLocationPermissionDenied();
        break;
    }
  }
}