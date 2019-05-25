import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

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
  String adminId;
  User userAdmin;
  GeoPoint geoPoint;

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
    this.geoPoint,
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
    'geoPoint': geoPoint,
    'adminId': userAdmin.id,
    'userAdmin': userAdmin.toMap()
  };

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
    geoPoint = snapshot['geoPoint'];
    adminId = snapshot['adminId'];
    userAdmin = snapshot['userAdmin'];
  }
}

abstract class AgentRepository {
  Future<List<Agent>> fetchAgentsByCity(String city);
  Future<List<Agent>> getAgents();
  Future<Agent> fetchAgent(String agentId);
  Future<List<Agent>> fetchAgentsNearby(double latitude, double longitude, double radius);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}