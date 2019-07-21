import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class ItemListViewContract {
  
}

class ItemListPresenter {
  ItemListViewContract _view;
  TransactionRepository _transactionRepo;

  ItemListPresenter(this._view) {
    _transactionRepo = Injector().transactionRepository;
  }
}