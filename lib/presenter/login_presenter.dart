import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class LoginViewContract {
  void onLoginSuccess(User user);
  void onLoginError();
}

class LoginPresenter {
  LoginViewContract _view;
  UserRepository _userRepo;

  LoginPresenter(this._view) {
    _userRepo = Injector().userRepository;
  }

  void loginUser(String email, String password) {
    _userRepo.loginUser(email, password)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError());
  }

  bool validateEmail(String email) {
    return false;
  }

  bool validatePassword(String password) {
    return false;
  }

  bool isSignedIn() {
    return false;
  }
}