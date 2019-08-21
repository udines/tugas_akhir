import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AgentRepository {
  Future<Agent> fetchAgent(String agentId);
  Future<List<DocumentSnapshot>> fetchAgents();
  Future<List<Agent>> fetchAgentsNearby(double latitude, double longitude, double radius);
  Future<void> postAgent(Agent agent);
  Future<void> postAgents(List<Agent> agents);
}

class Agent {
  String id;
  String address;
  bool isReceiveOrder;
  String name;
  String phone;
  String timeOpen;
  String timeClose;
  String adminId;
  GeoPoint geoPoint;

  Agent({
    this.id = '',
    this.address = '',
    this.isReceiveOrder = true,
    this.name = '',
    this.phone = '',
    this.timeOpen = '',
    this.timeClose = '',
    this.geoPoint,
    this.adminId = '',
  });

  Map<String, dynamic> toSnapshot() => {
    'id': id,
    'address': address,
    'isReceiveOrder': isReceiveOrder,
    'name': name,
    'phone': phone,
    'timeOpen': timeOpen,
    'timeClose': timeClose,
    'geoPoint': geoPoint,
    'adminId': adminId,
  };

  Agent.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    address = snapshot['address'];
    isReceiveOrder = snapshot['isReceiveOrder'];
    name = snapshot['name'];
    phone = snapshot['phone'];
    timeOpen = snapshot['timeOpen'];
    timeClose = snapshot['timeClose'];
    geoPoint = snapshot['geoPoint'];
    adminId = snapshot['adminId'];
  }

  Agent.fromMap(Map<dynamic, dynamic> data) {
    id = data['id'];
    address = data['address'];
    isReceiveOrder = data['isReceiveOrder'];
    name = data['name'];
    phone = data['phone'];
    timeOpen = data['timeOpen'];
    timeClose = data['timeClose'];
    geoPoint = data['geoPoint'];
    adminId = data['adminId'];
  }

  static List<Agent> listFromSnapshots(List<DocumentSnapshot> snapshots) {
    List<Agent> list = [];
    for (var snapshot in snapshots) {
      list.add(Agent.fromSnapshot(snapshot));
    }
    return list;
  }
}