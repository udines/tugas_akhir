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
  void onUpdateStatusSuccess();
}

class HomePresenter {
  HomeViewContract _view;
  PickupRepository _repository;
  UserRepository _userRepo;

  HomePresenter(this._view) {
    _repository = Injector().pickupRepository;
    _userRepo = Injector().userRepository;
  }

  testConstructor(HomeViewContract view, PickupRepository pickupRepo, UserRepository userRepo) {
    _view = view;
    _repository = pickupRepo;
    _userRepo = userRepo;
  }

  logoutUser() async {
    try {
      await _userRepo.logoutUser();
      _view.onLogoutSuccess();
    } catch(e) {
      print(e.toString());
    }
  }

  clearPreferences() {
    SharedPref().clearData();
  }

  loadPickupTransactions(String agentId) async {
    try {
      final pickups = await _repository.fetchPickupsByAgent(agentId);
      _view.onLoadPickupTransactionComplete(pickups);
    } catch(e) {
      _view.onLoadPickupTransactionError();
    }
  }

  getCurrentUser() async {
    try {
      final user = await _userRepo.fetchCurrentUser();
      _view.onGetCurrentUserComplete(user);
    } catch(e) {
      _view.onGetCurrentUserError();
    }
  }

  updateStatus(String status, String pickupId) async {
    try {
      await _repository.updateStatus(status, pickupId);
      _view.onUpdateStatusSuccess();
    } catch(e) {
      print(e.toString());
    }
  }
}