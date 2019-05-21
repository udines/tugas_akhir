import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AgentViewContract {
  void onLoadAgentComplete(List<Agent> agents);
  void onLoadAgentError();
  void onGetCityComplete(String city);
}

class AgentPresenter {
  AgentViewContract _view;
  AgentRepository _repository;
  LocationRepository _locationRepo;

  AgentPresenter(this._view) {
    _repository = new Injector().agentRepository;
    _locationRepo = Injector().locationRepository;
  }

  void loadAgentsByCity(String city) {
    _repository.fetchAgentsByCity(city)
        .then((agents) => _view.onLoadAgentComplete(agents))
        .catchError((onError) => _view.onLoadAgentError());
  }

  void getCityName() {
    _locationRepo.getCity()
        .then((city) => _view.onGetCityComplete(city));
  }

  void loadAgents() {
    _repository.getAgents()
        .then((agents) => _view.onLoadAgentComplete(agents));
  }
}