import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_data.dart';

class Agent {
  String id;
  String address;
  String city;
  int costPerKM;
  int costPerKG;
  bool isReceiveOrder;
  String name;
  String phone;
  String timeOpen;
  String timeClose;
  double latitude;
  double longitude;
  String adminId;
  User userAdmin;

  Agent({
    this.id,
    this.address,
    this.city,
    this.costPerKM,
    this.costPerKG,
    this.isReceiveOrder,
    this.name,
    this.phone,
    this.timeOpen,
    this.timeClose,
    this.latitude,
    this.longitude,
    this.adminId,
    this.userAdmin
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'address': address,
    'city': city,
    'costPerKM': costPerKM,
    'costPerKG': costPerKG,
    'isReceiveOrder': isReceiveOrder,
    'name': name,
    'phone': phone,
    'timeOpen': timeOpen,
    'timeClose': timeClose,
    'latitude': latitude,
    'longitude': longitude,
    'adminId': adminId,
    'userAdmin': userAdmin.toMap()
  };

  Agent.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.address = map['address'];
    this.city = map['city'];
    this.costPerKM = map['costPerKM'];
    this.costPerKG = map['costPerKG'];

  }

  Agent.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    address = snapshot['address'];
    city = snapshot['city'];
    costPerKM = snapshot['costPerKM'];
    costPerKG = snapshot['costPerKG'];
    isReceiveOrder = snapshot['isReceiveOrder'];
    name = snapshot['name'];
    phone = snapshot['phone'];
    timeOpen = snapshot['timeOpen'];
    timeClose = snapshot['timeClose'];
    latitude = snapshot['latitude'];
    longitude = snapshot['longitude'];
    adminId = snapshot['adminId'];
    userAdmin = snapshot['userAdmin'];
  }
}

abstract class AgentRepository {
  Future<List<Agent>> fetchAgentsByCity(String city);
  Future<List<Agent>> getAgents();
  Future<Agent> fetchAgent(String agentId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}