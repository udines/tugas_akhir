import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> fetchTransactions(String pickupId);
  Future<Transaction> fetchTransaction(String transactionId);
  Future<void> postTransactions(List<Transaction> transactions);
  Future<void> postTransaction(Transaction transaction);
}

class Transaction {
  String id;
  //item information
  String itemName;
  String itemType;
  int itemWeight;
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
  //Relation
  String userId;
  String agentId;
  String pickupId;

  Transaction({
    this.id = '',
    this.itemName = '',
    this.itemType = '',
    this.itemWeight = 1,
    this.senderName = '',
    this.senderPhone = '',
    this.senderProvince = '',
    this.senderAddress = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.receiverProvince = '',
    this.receiverAddress = '',
    this.userId = '',
    this.agentId = '',
    this.pickupId = ''
  });

  Map<String, dynamic> toSnapshot() => {
    'id': id,
    'itemName': itemName,
    'itemType': itemType,
    'itemWeight': itemWeight,
    'senderName': senderName,
    'senderPhone': senderPhone,
    'senderProvince': senderProvince,
    'senderAddress': senderAddress,
    'receiverName': receiverName,
    'receiverPhone': receiverPhone,
    'receiverProvince': receiverProvince,
    'receiverAddress': receiverAddress,
    'userId': userId,
    'agentId': agentId,
    'pickupId': pickupId
  };

  Transaction.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    itemName = snapshot['itemName'];
    itemType = snapshot['itemType'];
    itemWeight = snapshot['itemWeight'];
    senderName = snapshot['senderName'];
    senderPhone = snapshot['senderPhone'];
    senderProvince = snapshot['senderProvince'];
    senderAddress = snapshot['senderAddress'];
    receiverName = snapshot['receiverName'];
    receiverPhone = snapshot['receiverPhone'];
    receiverProvince = snapshot['receiverProvince'];
    receiverAddress = snapshot['receiverAddress'];
    userId = snapshot['userId'];
    agentId = snapshot['agentId'];
    pickupId = snapshot['pickupId'];
  }

  static List<Transaction> listFromSnapshot(List<DocumentSnapshot> snapshots) {
    List<Transaction> list = [];
    for (var document in snapshots) {
      list.add(Transaction.fromSnapshot(document));
    }
    return list;
  }
}