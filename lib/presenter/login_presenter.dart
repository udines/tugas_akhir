import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class LoginViewContract {
  void onLoginSuccess(User user);
  void onLoginError();
  void onCredentialInvalid(bool isEmailValid, bool isPasswordValid);
  void onUserCheckSuccess(User user);
  void showLoading(bool isShowing);
}

class LoginPresenter {
  LoginViewContract _view;
  UserRepository _userRepo;

  LoginPresenter(this._view) {
    _userRepo = Injector().userRepository;
  }

  void loginUser(String email, String password) {
    if (checkCredentials(email, password)) {
      _view.showLoading(true);
      _userRepo.loginUser(email, password)
        .then((user) => {
          _view.onLoginSuccess(user),
          _view.showLoading(false)
        })
        .catchError((onError) => {
          _view.showLoading(false),
          _view.onLoginError()
        });
    }
  }

  bool checkCredentials(String email, String password) {
    if (validateEmail(email) && validatePassword(password)) {
      return true;
    } else {
      _view.onCredentialInvalid(validateEmail(email), validatePassword(password));
      return false;
    }
  }

  bool validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }

  void checkUserLoggedIn() {
    _userRepo.fetchCurrentUser()
      .then((user) => _view.onUserCheckSuccess(user))
      .catchError((onError) => {});
  }

  void saveUserInformation(User user) {
    _userRepo.saveUserInfo(user);
  }
}