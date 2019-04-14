import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AgentViewContract {
  void onLoadAgentComplete(List<Agent> agents);
  void onLoadAgentError();
}

class AgentPresenter {
  AgentViewContract _view;
  AgentRepository _repository;

  AgentPresenter(this._view) {
    _repository = new Injector().agentRepository;
  }

  void loadAgents() {
    _repository.fetchAgents()
        .then((agents) => _view.onLoadAgentComplete(agents))
        .catchError((onError) => _view.onLoadAgentError());
  }
}