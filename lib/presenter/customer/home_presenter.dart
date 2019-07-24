import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';
import 'package:tugas_akhir/utils/shared_preferences.dart';

abstract class HomeViewContract {
  void onLogoutSuccess();
}

class HomePresenter {
  HomeViewContract _view;
  UserRepository _userRepository;

  HomePresenter(this._view) {
    _userRepository = Injector().userRepository;
  }

  void logoutUser() {
    _userRepository.logoutUser().then((onValue) {
      _view.onLogoutSuccess();
    });
  }

  void clearPreferences() {
    SharedPref().clearData();
  }
}