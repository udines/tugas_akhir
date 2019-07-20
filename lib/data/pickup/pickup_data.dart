import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PickupRepository {
  Future<List<Pickup>> fetchPickupsByUser(String userId);
  Future<List<Pickup>> fetchPickupsByAgent(String agentId);
  Future<Pickup> fetchPickup(String pickupId);
}

class Pickup {
  String id;
  Timestamp timestamp;
  GeoPoint geoPoint;
  String status;
  //Relations
  String agentId;
  String userId;

  Pickup({
    this.id,
    this.timestamp,
    this.geoPoint,
    this.status,
    this.agentId,
    this.userId,
  });

  Map<String, dynamic> toSnapshot() => {
    'id': id,
    'agentId': agentId,
    'timestamp': timestamp,
    'geoPoint': geoPoint,
    'status': status,
    'agentId': agentId,
    'userId': userId,
  };

  Pickup.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    agentId = snapshot['agentId'];
    timestamp = snapshot['timestamp'];
    geoPoint = snapshot['geoPoint'];
    status = snapshot['status'];
    agentId = snapshot['agentId'];
    userId = snapshot['userId'];
  }
}