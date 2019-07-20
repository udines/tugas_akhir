import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AgentDetailViewContract {
  void onLoadAgentComplete(Agent agent);
  void onLoadAgentError();
  void onGetCurrentUserComplete(User user);
  void onGetCurrentUserError();
}

class AgentDetailPresenter {
  AgentDetailViewContract _view;
  AgentRepository _repository;
  UserRepository _userRepo;

  AgentDetailPresenter(this._view) {
    _repository = new Injector().agentRepository;
    _userRepo = new Injector().userRepository;
  }

  void loadAgent(String agentId) {
    _repository.fetchAgent(agentId)
        .then((agent) => _view.onLoadAgentComplete(agent))
        .catchError((onError) => _view.onLoadAgentError());
  }

  void getCurrentUser() {
    _userRepo.fetchCurrentUser()
        .then((user) => _view.onGetCurrentUserComplete(user))
        .catchError((onError) => _view.onGetCurrentUserError());
  }

  bool isAgentOpen(Agent agent, DateTime now) {
    bool isOpen = true;
    String strFormatOpen = dateToString(now) + " " + agent.timeOpen + ":00";
    String strFormatClose = dateToString(now) + " " + agent.timeClose + ":00";
    DateTime dateOpen, dateClose;
    dateOpen = DateTime.parse(strFormatOpen);
    dateClose = DateTime.parse(strFormatClose);
    if(now.compareTo(dateOpen) >= 0 && now.compareTo(dateClose) <= 0) {
      isOpen = true;
    } else {
      isOpen = false;
    }
    return isOpen;
  }

  String dateToString(DateTime date) {
    int year, month, day;
    year = date.year;
    month = date.month;
    day = date.day;
    String strMonth, strDay;
    if (month < 10) {
      strMonth = "0" + month.toString();
    } else {
      strMonth = month.toString();
    }
    if (day < 10) {
      strDay = "0" + day.toString();
    } else {
      strDay = day.toString();
    }
    return year.toString() + "-" + strMonth + "-" + strDay;
  }
}