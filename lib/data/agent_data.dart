import 'package:location/location.dart';

import 'user_data.dart';

class Agent {
  String id;
  String address;
  int costPerKM;
  int costPerKG;
  bool isReceiveOrder;
  String name;
  String phone;
  String timeOpen;
  String timeClose;
  double latitude;
  double longitude;
  User userAdmin;

  Agent({
    this.id,
    this.address,
    this.costPerKM,
    this.costPerKG,
    this.isReceiveOrder,
    this.name,
    this.phone,
    this.timeOpen,
    this.timeClose,
    this.latitude,
    this.longitude,
    this.userAdmin
  });
}

abstract class AgentRepository {
  Future<List<Agent>> fetchAgents();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}