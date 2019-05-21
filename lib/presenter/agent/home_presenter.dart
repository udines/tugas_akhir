import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class HomeViewContract {
  void onLoadPickupTransactionComplete(List<Pickup> pickups);
  void onLoadPickupTransactionError();
  void onGetCurrentUserComplete(User user);
  void onGetCurrentUserError();
}

class HomePresenter {
  HomeViewContract _view;
  PickupTransactionRepository _repository;
  UserRepository _userRepo;

  HomePresenter(this._view) {
    _repository = Injector().pickupRepository;
    _userRepo = Injector().userRepository;
  }

  void loadPickupTransactions(String agentId) {
    _repository.fetchPickupTransactionsByUser(agentId)
        .then((pickups) => _view.onLoadPickupTransactionComplete(pickups))
        .catchError((onError) => _view.onLoadPickupTransactionError());
  }

  void getCurrentUser() {
    _userRepo.fetchCurrentUser()
        .then((user) => _view.onGetCurrentUserComplete(user))
        .catchError((onError) => _view.onGetCurrentUserError());
  }
}