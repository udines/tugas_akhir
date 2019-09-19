import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class LoginViewContract {
  void onLoginSuccess(User user);
  void onLoginError();
  void onCredentialInvalid(bool isEmailValid, bool isPasswordValid);
  void onUserCheckSuccess(User user);
  void showLoading(bool isShowing, String message);
}

class LoginPresenter {
  LoginViewContract _view;
  UserRepository _userRepo;

  LoginPresenter(this._view) {
    _userRepo = Injector().userRepository;
  }

  testConstructor(LoginViewContract view, UserRepository repo) {
    _view = view;
    _userRepo = repo;
  }

  loginUser(String email, String password) async {
    if (checkCredentials(email, password)) {
      _view.showLoading(true, 'Login');
      try {
        final user = await _userRepo.loginUser(email, password);
        _view.onLoginSuccess(user);
        _view.showLoading(false, 'Login');
      } catch(e) {
        _view.showLoading(false, 'Login');
        _view.onLoginError();
      }
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

  checkUserLoggedIn() async {
    try {
      final user = await _userRepo.fetchCurrentUser();
      _view.onUserCheckSuccess(user);
    } catch(e) {
      print(e.toString());
    }
  }

  saveUserInformation(User user) {
    _userRepo.saveUserInfo(user);
  }
}