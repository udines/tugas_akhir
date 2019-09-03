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

  testConstructor(AgentListViewContract view, AgentRepository agentRepo, LocationRepository locRepo) {
    _view = view;
    _repository = agentRepo;
    _locationRepo = locRepo;
  }

  AgentListViewContract getView() => _view;
  AgentRepository getRepo() => _repository;

  fetchAgentsNearby(double latitude, double longitude, double radius) async {
    try {
      final agents = await _repository.fetchAgentsNearby(latitude, longitude, radius);
      _view.onLoadAgentComplete(agents);
    } catch(e) {
      _view.onLoadAgentError();
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