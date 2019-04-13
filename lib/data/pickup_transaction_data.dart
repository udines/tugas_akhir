import 'agent_data.dart';
import 'transaction_data.dart';
import 'user_data.dart';

class PickupTransaction {
  String id;
  DateTime date;
  double latitude;
  double longitude;
  List<Transaction> transactions;
  //Relations
  Agent agent;
  User user;

  PickupTransaction({
    this.id,
    this.date,
    this.latitude,
    this.longitude,
    this.transactions,
    this.agent,
    this.user
  });
}

abstract class PickupTransactionRepository {
  Future<List<PickupTransaction>> fetchPickupTransactions();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}