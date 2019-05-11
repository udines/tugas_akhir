import 'agent_data.dart';
import 'item_data.dart';
import 'user_data.dart';

class Transaction {
  String id;
  //Sender information
  String senderName;
  String senderPhone;
  String senderProvince;
  String senderAddress;
  //Receiver information
  String receiverName;
  String receiverPhone;
  String receiverProvince;
  String receiverAddress;
  DateTime date;
  //Relations
  Item barang;
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
    this.barang,
    this.user,
    this.agent
  });
}

abstract class TransactionRepository {
  Future<List<Transaction>> fetchTransactions();
  Future<Transaction> fetchTransaction(String transactionId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}