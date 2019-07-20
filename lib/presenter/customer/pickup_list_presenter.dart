import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class PickupViewContract {
  void onLoadPickupTransactionComplete(List<Pickup> pickups);
  void onLoadPickupTransactionError();
}

class PickupPresenter {
  PickupViewContract _view;
  PickupTransactionRepository _repository;

  PickupPresenter(this._view) {
    _repository = new Injector().pickupRepository;
  }

  void loadPickupsByUser(String userId) {
    _repository.fetchPickupsByUser(userId)
        .then((pickups) => _view.onLoadPickupTransactionComplete(pickups))
        .catchError((onError) => _view.onLoadPickupTransactionError());
  }
}