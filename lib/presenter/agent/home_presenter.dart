import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';
import 'package:tugas_akhir/utils/shared_preferences.dart';

abstract class HomeViewContract {
  void onLoadPickupTransactionComplete(List<Pickup> pickups);
  void onLoadPickupTransactionError();
  void onGetCurrentUserComplete(User user);
  void onGetCurrentUserError();
  void onLogoutSuccess();
}

class HomePresenter {
  HomeViewContract _view;
  PickupRepository _repository;
  UserRepository _userRepo;

  HomePresenter(this._view) {
    _repository = Injector().pickupRepository;
    _userRepo = Injector().userRepository;
  }

  void logoutUser() {
    _userRepo.logoutUser().then((onValue) {
      _view.onLogoutSuccess();
    });
  }

  void clearPreferences() {
    SharedPref().clearData();
  }

  void loadPickupTransactions(String agentId) async {
    try {
      final pickups = await _repository.fetchPickupsByAgent(agentId);
      _view.onLoadPickupTransactionComplete(pickups);
    } catch(e) {
      _view.onLoadPickupTransactionError();
    }
  }

  void getCurrentUser() async {
    try {
      final user = await _userRepo.fetchCurrentUser();
      _view.onGetCurrentUserComplete(user);
    } catch(e) {
      _view.onGetCurrentUserError();
    }
  }
}