import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class RegisterViewContract {
  void onRegisterSuccess(User user);
  void onRegisterFailed();
  void showLoading(bool isLoading);
}

class RegisterPresenter {
  RegisterViewContract _view;
  UserRepository _repo;

  RegisterPresenter(this._view) {
    _repo = Injector().userRepository;
  }

  void registerUser(String email, String password, User user) {
    _view.showLoading(true);
    _repo.registerUser(email, password, user)
      .then((onValue) => {
        _view.onRegisterSuccess(user), 
        _view.showLoading(false)
      })
      .catchError((onError) => {
        _view.onRegisterFailed(),
        _view.showLoading(false)
      });
  }
}