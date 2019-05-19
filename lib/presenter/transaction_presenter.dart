import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class TransactionViewContract {
  void onLoadTransactionComplete(List<Transaction> transactions);
  void onLoadTransactionError();
}

class TransactionPresenter {
  TransactionViewContract _view;
  TransactionRepository _repository;

  TransactionPresenter(this._view) {
    _repository = new Injector().transactionRepository;
  }

  void loadTransactions(String pickupId) {
    _repository.fetchTransactions(pickupId)
        .then((transactions) => _view.onLoadTransactionComplete(transactions))
        .catchError((onError) => _view.onLoadTransactionError());
  }
}