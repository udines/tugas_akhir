import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class LoginViewContract {
  void onLoginSuccess(User user);
  void onLoginError();
  void onEmailInvalid();
  void onPasswordInvalid();
  void onUserLoggedIn(User user);
}

class LoginPresenter {
  LoginViewContract _view;
  UserRepository _userRepo;

  LoginPresenter(this._view) {
    _userRepo = Injector().userRepository;
  }

  void loginUser(String email, String password) {
    if (validateEmail(email) && validatePassword(password)) {
      _userRepo.loginUser(email, password)
          .then((user) => _view.onLoginSuccess(user))
          .catchError((onError) => _view.onLoginError());
    }
  }

  bool validateEmail(String email) {
    if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return true;
    } else {
      _view.onEmailInvalid();
      return false;
    }
  }

  bool validatePassword(String password) {
    if (password.length < 6) {
      _view.onPasswordInvalid();
      return false;
    } else {
      return true;
    }
  }

  void checkUserLoggedIn() {
    _userRepo.fetchCurrentUser()
        .then((user) => {if (user !=null) _view.onUserLoggedIn(user)});
  }
}