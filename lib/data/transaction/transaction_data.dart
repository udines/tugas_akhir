import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/item/item_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

class Transaction {
  String id;
  //Sender information
  String senderName;
  String senderPhone;
  String senderProvince = "Provinsi";
  String senderAddress;
  //Receiver information
  String receiverName;
  String receiverPhone;
  String receiverProvince = "Provinsi";
  String receiverAddress;
  DateTime date;
  //Relations
  Item item;
  User user;
  Agent agent;

  Transaction({
    this.id,
    this.senderName,
    this.senderPhone,
    this.senderProvince,
    this.senderAddress,
    this.receiverName,
    this.receiverPhone,
    this.receiverProvince,
    this.receiverAddress,
    this.date,
    this.item,
    this.user,
    this.agent
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'senderName': senderName,
    'senderPhone': senderPhone,
    'senderProvince': senderProvince,
    'senderAddress': senderAddress,
    'receiverName': receiverName,
    'receiverPhone': receiverPhone,
    'receiverProvince': receiverProvince,
    'receiverAddress': receiverAddress,
    'date': date, //need mapping
    'item': item.toMap(),
    'user': user.toMap(),
    'agent': agent.toMap()
  };
}

abstract class TransactionRepository {
  Future<List<Transaction>> fetchTransactions(String pickupId);
  Future<Transaction> fetchTransaction(String pickupId, String transactionId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}