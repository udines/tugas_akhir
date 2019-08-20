import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class TransactionListViewContract {
  void onLoadTransactionComplete(List<Transaction> transactions);
  void onLoadTransactionError();
}

class TransactionListPresenter {
  TransactionListViewContract _view;
  TransactionRepository _repository;

  TransactionListPresenter(this._view) {
    _repository = new Injector().transactionRepository;
  }

  void loadTransactions(String pickupId) async {
    try {
      final transactions = await _repository.fetchTransactions(pickupId);
      _view.onLoadTransactionComplete(transactions);
    } catch(e) {
      _view.onLoadTransactionError();
    }
  }
}