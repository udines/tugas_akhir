import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';
import 'package:tugas_akhir/utils/shared_preferences.dart';

abstract class HomeViewContract {
  void onLogoutSuccess();
  void onLogoutFail();
}

class HomePresenter {
  HomeViewContract _view;
  UserRepository _userRepository;

  HomePresenter(this._view) {
    _userRepository = Injector().userRepository;
  }

  testConstructor(HomeViewContract view, UserRepository repo) {
    _view = view;
    _userRepository = repo;
  }

  logoutUser() async {
    try {
      await _userRepository.logoutUser();
      _view.onLogoutSuccess();
    } catch(e) {
      _view.onLogoutFail();
    }
  }

  void clearPreferences() {
    SharedPref().clearData();
  }
}