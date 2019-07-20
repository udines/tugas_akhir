import 'package:tugas_akhir/data/item/item_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class ItemListViewContract {
  void onLoadItemsComplete(List<Item> items);
  void onLoadTransactionsComplete(List<Transaction> transactions, List<Item> items);
}

class ItemListPresenter {
  ItemListViewContract _view;
  TransactionRepository _transactionRepo;

  ItemListPresenter(this._view) {
    _transactionRepo = Injector().transactionRepository;
  }

  void fetchItems(String pickupId) {
    List<Item> items = [];
    _transactionRepo.fetchTransactions(pickupId)
        .then((transactions) => {
          for (var transaction in transactions) {
            items.add(transaction.item)
          },
          _view.onLoadTransactionsComplete(transactions, items)
    });
  }
}