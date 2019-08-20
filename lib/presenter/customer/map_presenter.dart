import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class MapViewContract {
  void onGetCurrentUserLocationComplete(double latitude, double longitude);
  void onLocationPermissionGranted();
  void onLocationPermissionDenied();
  void onLoadAgentComplete(List<Agent> agents);
}

class MapPresenter {
  MapViewContract _view;
  AgentRepository _agentRepo;
  LocationRepository _locationRepo;

  MapPresenter(this._view) {
    _agentRepo = Injector().agentRepository;
    _locationRepo = Injector().locationRepository;
  }

  void fetchAgentsNearby(double latitude, double longitude, double radius) async {
    List<Agent> list = [];
    _agentRepo.fetchAgentsNearby(latitude, longitude, radius)
      .then((documents) => {
        documents.forEach((DocumentSnapshot snapshot) => {
          list.add(Agent.fromSnapshot(snapshot))
        }),
        _view.onLoadAgentComplete(list)
      });
  }

  void fetchAgents() {
    List<Agent> list = [];
    _agentRepo.fetchAgents()
      .then((documents) => {
        documents.forEach((DocumentSnapshot snapshot) => {
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