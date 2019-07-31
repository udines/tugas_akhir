import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PickupRepository {
  Future<List<Pickup>> fetchPickupsByUser(String userId);
  Future<List<Pickup>> fetchPickupsByAgent(String agentId);
  Future<Pickup> fetchPickup(String pickupId);
  Future<void> postPickup(Pickup pickup);
  Future<void> postPickups(List<Pickup> pickups);
}

class Pickup {

  static const STATUS_PROCESS = 'proses';
  static const STATUS_CANCEL = 'batal';
  static const STATUS_COMPLETED = 'selesai';
  static const STATUS_WAITING = 'menunggu';

  String id;
  Timestamp timestamp;
  GeoPoint geoPoint;
  String status;
  //Relations
  String agentId;
  String userId;

  Pickup({
    this.id = '',
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