import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class PickupViewContract {
  void onLoadPickupTransactionComplete(List<Pickup> pickups);
  void onLoadPickupTransactionError();
}

class PickupPresenter {
  PickupViewContract _view;
  PickupRepository _repository;
  UserRepository _userRepo;

  PickupPresenter(this._view) {
    _repository = Injector().pickupRepository;
    _userRepo = Injector().userRepository;
  }

  void loadPickupsByUser() async {
    try {
      final userId = await _userRepo.getUserId();
      final pickups = await _repository.fetchPickupsByUser(userId);
      _view.onLoadPickupTransactionComplete(pickups);
    } catch(e) {
      _view.onLoadPickupTransactionError();
    }
  }
}