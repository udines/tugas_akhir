import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tugas_akhir/data/pickup/pickup_transaction_data.dart';

class ProdPickupTransactionRepository implements PickupTransactionRepository {
  @override
  Future<List<PickupTransaction>> fetchPickupTransactionsByUser(String userId) async {
    List<PickupTransaction> list = [];
    CollectionReference pickupRef = Firestore.instance.collection('pickups');
    Query query = pickupRef.where('userId', isEqualTo: userId);
    query.snapshots().listen((data) => {
      for (var document in data.documents) {
        list.add(document as PickupTransaction)
      }
    });
    return list;
  }

  @override
  Future<List<PickupTransaction>> fetchPickupTransactionsByAgent(String agentId) async {
    List<PickupTransaction> list = [];
    Firestore.instance.collection('pickups').where('agentId', isEqualTo: agentId)
      .snapshots().listen((snapshots) => {
        for (var document in snapshots.documents) {
          list.add(document as PickupTransaction)
        }
      });
    return list;
  }
}