import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AgentRepository {
  Future<Agent> fetchAgent(String agentId);
  Future<List<Agent>> fetchAgentsNearby(double latitude, double longitude, double radius);
  Future<void> postAgent(Agent agent);
}

class Agent {
  String id;
  String address;
  String city;
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
    this.city = '',
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
    'city': city,
    'isReceiveOrder': isReceiveOrder,
    'name': name,
    'phone': phone,
    'timeOpen': timeOpen,
    'timeClose': timeClose,
    'geoPoint': geoPoint,
    'adminId': adminId,
  };

  Agent.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    address = snapshot['address'];
    city = snapshot['city'];
    isReceiveOrder = snapshot['isReceiveOrder'];
    name = snapshot['name'];
    phone = snapshot['phone'];
    timeOpen = snapshot['timeOpen'];
    timeClose = snapshot['timeClose'];
    geoPoint = snapshot['geoPoint'];
    adminId = snapshot['adminId'];
  }
}