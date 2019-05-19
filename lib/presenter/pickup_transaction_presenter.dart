import 'package:tugas_akhir/data/pickup/pickup_transaction_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class PickupTransactionViewContract {
  void onLoadPickupTransactionComplete(List<PickupTransaction> pickups);
  void onLoadPickupTransactionError();
}

class PickupTransactionPresenter {
  PickupTransactionViewContract _view;
  PickupTransactionRepository _repository;

  PickupTransactionPresenter(this._view) {
    _repository = new Injector().pickupTransactionRepository;
  }

  void loadPickupTransactionsUser(String userId) {
    _repository.fetchPickupTransactionsByUser(userId)
        .then((pickups) => _view.onLoadPickupTransactionComplete(pickups))
        .catchError((onError) => _view.onLoadPickupTransactionError());
  }
}