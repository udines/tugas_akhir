import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

class Pickup {
  String id;
  DateTime date;
  double latitude;
  double longitude;
  String status;
  List<Transaction> transactions;
  //Relations
  String agentId;
  Agent agent;
  String userId;
  User user;

  Pickup({
    this.id,
    this.date,
    this.latitude,
    this.longitude,
    this.transactions,
    this.agentId,
    this.agent,
    this.userId,
    this.user,
    this.status
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
    'user': user.toMap(),
    'status': status
  };
}

abstract class PickupTransactionRepository {
  Future<List<Pickup>> fetchPickupsByUser(String userId);
  Future<List<Pickup>> fetchPickupsByAgent(String agentId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}