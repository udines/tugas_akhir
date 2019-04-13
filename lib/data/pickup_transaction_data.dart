import 'agent_data.dart';
import 'transaction_data.dart';
import 'user_data.dart';

class PickupTransaction {
  String id;
  DateTime date;
  List<Transaction> transactions;
  //Relations
  Agent agent;
  User user;

  int getTotalWeight() {
    int _weight = 0;
    for (var transaction in transactions) {
      _weight = _weight + transaction.barang.weight;
    }
    return _weight;
  }
}