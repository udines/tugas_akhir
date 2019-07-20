import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';

class ProdAgentRepository implements AgentRepository {

  final _agentCollection = Firestore.instance.collection('agents');

  @override
  Future<Agent> fetchAgent(String agentId) async {
    final snapshot = await _agentCollection.document(agentId).get();
    return Agent.fromSnapshot(snapshot);
  }

  @override
  Future<List<Agent>> fetchAgentsNearby(double latitude, double longitude, double rad) async {
    List<Agent> agents = [];
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);

    double radius = rad;
    String field = 'geoPoint';

    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: _agentCollection)
        .within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      for (var document in documentList) {
        agents.add(Agent.fromSnapshot(document));
      }
    });
    return agents;
  }
}