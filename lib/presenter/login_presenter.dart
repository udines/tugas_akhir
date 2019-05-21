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

  void loginAgent(String email, String password) {

  }

  void loginCustomer(String email, String password) {

  }

  bool validateEmail(String email) {
    return true;
  }
}