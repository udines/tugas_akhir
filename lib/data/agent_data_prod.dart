import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas_akhir/data/agent_data.dart';

class ProdAgentRepository implements AgentRepository {
  @override
  Future<List<Agent>> fetchAgentsByCity(String city) async {
    List<Agent> list = [];
    Firestore.instance.collection('agents').where('city', isEqualTo: city)
    .snapshots().listen((data) => {
      for (var document in data.documents) {
        list.add(document as Agent)
      }
    });
    return list;
  }

  @override
  Future<Agent> fetchAgent(String agentId) async {
    Agent agent;
    DocumentReference agentRef = Firestore.instance.collection('agents').document(agentId);
    DocumentSnapshot agentSnaps = await agentRef.get();
    if (agentSnaps.exists) {
      agent = agentSnaps.data as Agent;
    }
    return agent;
  }

  @override
  Future<List<Agent>> getAgents() async {
    // String city;
    List<Agent> list = [];

    // Position position = await Geolocator().getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.high
    // );

    // List<Placemark> placemark = await Geolocator()
    // .placemarkFromCoordinates(position.latitude, position.longitude);
    // city = placemark[0].locality;

    Firestore.instance.collection('agents').where('city', isEqualTo: 'Yogyakarta')
    .snapshots().listen((data) => {
      for (var document in data.documents) {
        list.add(document as Agent)
      }
    });

    // QuerySnapshot snapshot = await Firestore.instance.collection('agents')
    // .where('city', isEqualTo: 'Yogyakarta').getDocuments();

    // for (var document in snapshot.documents) {
    //   list.add(document as Agent);
    // }

    return list;
  }
}