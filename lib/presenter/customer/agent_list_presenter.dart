import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AgentListViewContract {
  void onLoadAgentComplete(List<Agent> agents);
  void onLoadAgentError();
  void onLocationPermissionGranted();
  void onLocationPermissionDenied();
  void onGetCurrentUserLocationComplete(double latitude, double longitude);
}

class AgentListPresenter {
  AgentListViewContract _view;
  AgentRepository _repository;
  LocationRepository _locationRepo;

  AgentListPresenter(this._view) {
    _repository = Injector().agentRepository;
    _locationRepo = Injector().locationRepository;
  }

  Future<List<DocumentSnapshot>> fetchAgentsNearby(double latitude, double longitude, double radius) {
    return _repository.fetchAgentsNearby(latitude, longitude, radius);
  }

  void fetchAgents() {
    List<Agent> list = [];
    _repository.fetchAgents().then((snapshots) => {
      snapshots.forEach((DocumentSnapshot snapshot) => {
        list.add(Agent.fromSnapshot(snapshot))
      }),
      _view.onLoadAgentComplete(list)
    });
  }

  void getUserCurrentLocation() {
    _locationRepo.getCurrentLocation()
      .then((location) => _view.onGetCurrentUserLocationComplete(
        location.latitude,
        location.longitude)
      );
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