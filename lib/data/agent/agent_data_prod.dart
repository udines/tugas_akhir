import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';

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
      agent = Agent.fromSnapshot(agentSnaps);
    }
    return agent;
  }

  @override
  Future<List<Agent>> getAgents() async {
    List<Agent> list = [];

    Firestore.instance.collection('agents').snapshots().listen((data) => {
      for (var document in data.documents) {
        list.add(Agent.fromSnapshot(document))
      }
    });

    return list;
  }

  @override
  Future<List<Agent>> fetchAgentsNearby(double latitude, double longitude, double rad) async {
    List<Agent> agents = [];
    /*Firestore firestore = Firestore.instance;
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);
    var collectionReference = firestore.collection('agents');

    double radius = rad;
    String field = 'geoPoint';

    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      for (var document in documentList) {
        agents.add(Agent.fromSnapshot(document));
      }
    });*/

    QuerySnapshot snapshots = await Firestore.instance.collection('agents').getDocuments();
    List<DocumentSnapshot> list = snapshots.documents;
    if (list.length > 0) {
      for (var document in list) {
        agents.add(Agent.fromSnapshot(document));
      }
    }
    return agents.length > 0 ? agents : null;
  }
}