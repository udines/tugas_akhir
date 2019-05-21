import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/transaction/transaction_data.dart';

class ProdTransactionRepository implements TransactionRepository {
  @override
  Future<Transaction> fetchTransaction(String pickupId, String transactionId) async {
    Transaction transaction;
    fs.Firestore.instance.collection('pickups').document(pickupId)
      .collection('transanctions').document(transactionId).get()
      .then((document) => transaction = document as Transaction);
    return transaction;
  }

  @override
  Future<List<Transaction>> fetchTransactions(String pickupId) async {
    List<Transaction> list = [];
    fs.Firestore.instance.collection('pickups').document(pickupId)
      .collection('transanctions').snapshots().listen((snapshots) => {
        for (var document in snapshots.documents) {
          list.add(document as Transaction)
        }
      });
    return list;
  }
  
}