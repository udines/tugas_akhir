import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AgentDetailViewContract {
  void onLoadAgentComplete(Agent agent);
  void onLoadAgentError();
}

class AgentDetailPresenter {
  AgentDetailViewContract _view;
  AgentRepository _repository;

  AgentDetailPresenter(this._view) {
    _repository = new Injector().agentRepository;
  }

  void loadAgent(String agentId) {
    _repository.fetchAgent(agentId)
        .then((agent) => _view.onLoadAgentComplete(agent))
        .catchError((onError) => _view.onLoadAgentError());
  }
}