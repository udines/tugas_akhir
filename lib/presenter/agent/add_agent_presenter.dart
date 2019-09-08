import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AddAgentViewContract {
  void onAddAgentSuccess();
  void onAddAgentFail();
}

class AddAgentPresenter {
  AddAgentViewContract _view;
  AgentRepository _agentRepo;

  AddAgentPresenter(this._view) {
    _agentRepo = Injector().agentRepository;
  }

  void addAgent(Agent agent) {
    _agentRepo.postAgent(agent)
      .then((onValue) => _view.onAddAgentSuccess())
      .catchError((onError) => _view.onAddAgentFail());
  }

  addAgents(List<Agent> agents) {
    _agentRepo.postAgents(agents);
  }
}