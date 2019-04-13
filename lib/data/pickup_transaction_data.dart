import 'agen_data.dart';
import 'transaction_data.dart';
import 'user_data.dart';

class PickupTransaction {
  String id;
  DateTime date;
  List<Transaction> transactions;
  //Relations
  Agen agen;
  User user;

  int getTotalWeight() {
    int _weight = 0;
    for (var transaction in transactions) {
      _weight = _weight + transaction.barang.weight;
    }
    return _weight;
  }

  int getDistance() {
    return 0;
  }

  int getTotalCost() {
    return agen.setting.getCost(getDistance(), getTotalWeight());
  }
}