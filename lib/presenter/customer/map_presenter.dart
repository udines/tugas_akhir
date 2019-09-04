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

  testConstructor(MapViewContract view, AgentRepository agentRepo, LocationRepository locRepo) {
    _view = view;
    _agentRepo = agentRepo;
    _locationRepo = locRepo;
  }

  fetchAgentsNearby(double latitude, double longitude, double radius) async {
    try {
      final agents = await _agentRepo.fetchAgentsNearby(latitude, longitude, radius);
      _view.onLoadAgentComplete(agents);
    } catch(e) {
      print(e.toString());
    }
  }

  getUserCurrentLocation() async {
    try {
      final location = await _locationRepo.getCurrentLocation();
      _view.onGetCurrentUserLocationComplete(location.latitude, location.longitude);
    } catch(e) {

    }
  }

  checkLocationPermission() async {
    try {
      final status = await _locationRepo.getLocationPermission();
      if (status == GeolocationStatus.granted) {
        _view.onLocationPermissionGranted();
      } else {
        _view.onLocationPermissionDenied();
      }
    } catch(e) {
      _view.onLocationPermissionDenied();
    }
  }

  requestLocationPermission() async {
    try {
      final response = await _locationRepo.requestLocationPermission();
      switch (response[PermissionGroup.location]) {
        case PermissionStatus.granted:
          _view.onLocationPermissionGranted();
          break;
        default:
          _view.onLocationPermissionDenied();
          break;
      }
    } catch(e) {
      _view.onLocationPermissionDenied();
    }
  }
}