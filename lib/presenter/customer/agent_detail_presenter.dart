import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AgentDetailViewContract {
  void onGetCurrentUserComplete(User user);
  void onGetCurrentUserError();
}

class AgentDetailPresenter {
  AgentDetailViewContract _view;
  UserRepository _userRepo;

  AgentDetailPresenter(this._view) {
    _userRepo = Injector().userRepository;
  }

  testConstructor(AgentDetailViewContract view, UserRepository userRepo) {
    _view = view;
    _userRepo = userRepo;
  }

  getCurrentUser() async {
    try {
      final user = await _userRepo.fetchCurrentUser();
      _view.onGetCurrentUserComplete(user);
    } catch(e) {
      _view.onGetCurrentUserError();
    }
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