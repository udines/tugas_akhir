import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/transaction/transaction_data.dart';

class ProdTransactionRepository implements TransactionRepository {

  static fs.Firestore db = fs.Firestore.instance;
  final _transactionCollection = db.collection('transactions');

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

  @override
  Future<void> postTransaction(Transaction transaction) async {
    return await _transactionCollection.document(transaction.id).setData(transaction.toSnapshot());
  }

  @override
  Future<void> postTransactions(List<Transaction> transactions) async {
    var batch = db.batch();
    for (var transaction in transactions) {
      var dataRef = _transactionCollection.document(transaction.id);
      batch.setData(dataRef, transaction.toSnapshot());
    }
    return await batch.commit();
  }
  
}