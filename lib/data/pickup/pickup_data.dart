import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

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
  Agent agent;
  User user;

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
    agent = Agent.fromMap(snapshot['agent']);
    user = User.fromMap(snapshot['user']);
  }

  String getStringDate() {
    return DateFormat.yMMMMd("en_US").format(timestamp.toDate());
  }

  static List<Pickup> listFromSnapshots(List<DocumentSnapshot> snapshots) {
    List<Pickup> list = [];
    for (var snapshot in snapshots) {
      list.add(Pickup.fromSnapshot(snapshot));
    }
    return list;
  }
}