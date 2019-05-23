import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tugas_akhir/data/pickup/pickup_data.dart';

class ProdPickupRepository implements PickupTransactionRepository {
  @override
  Future<List<Pickup>> fetchPickupsByUser(String userId) async {
    List<Pickup> list = [];
    CollectionReference pickupRef = Firestore.instance.collection('pickups');
    Query query = pickupRef.where('userId', isEqualTo: userId);
    query.snapshots().listen((data) => {
      for (var document in data.documents) {
        list.add(document as Pickup)
      }
    });
    return list;
  }

  @override
  Future<List<Pickup>> fetchPickupsByAgent(String agentId) async {
    List<Pickup> list = [];
    Firestore.instance.collection('pickups').where('agentId', isEqualTo: agentId)
      .snapshots().listen((snapshots) => {
        for (var document in snapshots.documents) {
          list.add(document as Pickup)
        }
      });
    return list;
  }
}