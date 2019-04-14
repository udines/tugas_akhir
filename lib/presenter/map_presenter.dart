import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class MapViewContract {
  void onLoadAgentComplete(List<Agent> agents);
  void onGetCurrentUserLocationComplete(double latitude, double longitude);
  void onGetCurrentUserLocationError();
  void onLoadAgentError();
}

class MapPresenter {
  MapViewContract _view;
  AgentRepository _agentRepo;
  LocationRepository _locationRepo;

  MapPresenter(this._view) {
    _agentRepo = new Injector().agentRepository;
    _locationRepo = new Injector().locationRepository;
  }

  void loadAgents() {
    _agentRepo.fetchAgents()
        .then((agents) => _view.onLoadAgentComplete(agents))
        .catchError((onError) => _view.onLoadAgentError());
  }

  void getUserCurrentLocation() {
    _locationRepo.getCurrentLocation()
        .then((location) => _view.onGetCurrentUserLocationComplete(
          location.latitude, 
          location.longitude))
        .catchError((onError) => _view.onGetCurrentUserLocationError());
  }
}