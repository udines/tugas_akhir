import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tugas_akhir/data/pickup/pickup_data.dart';

class ProdPickupRepository implements PickupRepository {

  static Firestore db = Firestore.instance;
  final _pickupCollection = db.collection('pickups');

  @override
  Future<List<Pickup>> fetchPickupsByUser(String userId) async {
    List<Pickup> list = [];
    _pickupCollection.where('userId', isEqualTo: userId)
      .snapshots().listen((snapshots) => {
        for (var snapshot in snapshots.documents) {
          list.add(Pickup.fromSnapshot(snapshot))
        }
      });
    return list;
  }

  @override
  Future<List<Pickup>> fetchPickupsByAgent(String agentId) async {
    final snapshots = await _pickupCollection.where('agentId', isEqualTo: agentId).snapshots().first;
    return Pickup.listFromSnapshots(snapshots.documents);
  }

  @override
  Future<Pickup> fetchPickup(String pickupId) async {
    final snapshot = await _pickupCollection.document(pickupId).get();
    return Pickup.fromSnapshot(snapshot);
  }

  @override
  Future<void> postPickup(Pickup pickup) {
    return _pickupCollection.document(pickup.id).setData(pickup.toSnapshot());
  }

  @override
  Future<void> postPickups(List<Pickup> pickups) async {
    final batch = db.batch();
    var docRef;
    pickups.forEach((pickup) => {
      docRef = _pickupCollection.document(pickup.id),
      batch.setData(docRef, pickup.toSnapshot())
    });
    return await batch.commit();
  }
}