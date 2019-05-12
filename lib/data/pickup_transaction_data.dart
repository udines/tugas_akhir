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
  String agentId;
  Agent agent;
  String userId;
  User user;

  PickupTransaction({
    this.id,
    this.date,
    this.latitude,
    this.longitude,
    this.transactions,
    this.agentId,
    this.agent,
    this.userId,
    this.user
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'date': date, //need mapping
    'latitude': latitude,
    'longitude': longitude,
    'transactions': transactions, //need mapping
    'agentId': agentId,
    'agent': agent.toMap(),
    'userId': userId,
    'user': user.toMap()
  };
}

abstract class PickupTransactionRepository {
  Future<List<PickupTransaction>> fetchPickupTransactionsByUser(String userId);
  Future<List<PickupTransaction>> fetchPickupTransactionsByAgent(String agentId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}