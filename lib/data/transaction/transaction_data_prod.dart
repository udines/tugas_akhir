import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/transaction/transaction_data.dart';

class ProdTransactionRepository implements TransactionRepository {

  fs.CollectionReference _transactionCollection =
  fs.Firestore.instance.collection('transactions');

  @override
  Future<Transaction> fetchTransaction(transactionId) async {
    final snapshot = await _transactionCollection.document(transactionId).get();
    return Transaction.fromSnapshot(snapshot);
  }

  @override
  Future<List<Transaction>> fetchTransactions(String pickupId) async {
    List<Transaction> list = [];
    _transactionCollection.where('pickupId', isEqualTo: pickupId)
      .snapshots().listen((snapshots) => {
        for (var snapshot in snapshots.documents) {
          list.add(Transaction.fromSnapshot(snapshot))
        }
      });
    return list;
  }
  
}