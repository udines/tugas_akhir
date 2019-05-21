import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class TransactionDetailViewContract {
  void onLoadTransactionComplete(Transaction transaction);
  void onLoadTransactionError();
}

class TransactionDetailPresenter {
  TransactionDetailViewContract _view;
  TransactionRepository _repository;

  TransactionDetailPresenter(this._view) {
    _repository = Injector().transactionRepository;
  }

  void loadTransactions(String pickupId, String transactionId) {
    _repository.fetchTransaction(pickupId, transactionId)
        .then((transactions) => _view.onLoadTransactionComplete(transactions))
        .catchError((onError) => _view.onLoadTransactionError());
  }
}