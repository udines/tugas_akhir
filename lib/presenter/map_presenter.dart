import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class MapViewContract {
  void onLoadAgentComplete(List<Agent> agents);
  void onGetCurrentUserLocationComplete(double latitude, double longitude);
  void onGetCurrentUserLocationError(String errorMessage);
  void onLoadAgentError();
  void onLocationPermissionGranted();
  void onLocationPermissionDenied();
}

class MapPresenter {
  MapViewContract _view;
  AgentRepository _agentRepo;
  LocationRepository _locationRepo;

  MapPresenter(this._view) {
    _agentRepo = new Injector().agentRepository;
    _locationRepo = new Injector().locationRepository;
  }

  void loadAgentsByCity(String city) {
    _agentRepo.fetchAgentsByCity(city)
        .then((agents) => _view.onLoadAgentComplete(agents))
        .catchError((onError) => _view.onLoadAgentError());
  }

  void loadAgents() {
    _agentRepo.getAgents()
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