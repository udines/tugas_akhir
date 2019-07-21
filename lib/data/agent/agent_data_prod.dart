import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';

class ProdAgentRepository implements AgentRepository {

  static final db = Firestore.instance;
  final _agentCollection = db.collection('agents');

  @override
  Future<Agent> fetchAgent(String agentId) async {
    final snapshot = await _agentCollection.document(agentId).get();
    return Agent.fromSnapshot(snapshot);
  }

  @override
  Future<List<DocumentSnapshot>> fetchAgentsNearby(double latitude, double longitude, double rad) {
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);

    double radius = rad;
    String field = 'geoPoint';

    return geo.collection(collectionRef: _agentCollection)
    .within(center: center, radius: radius, field: field).first;
  }

  @override
  Future<void> postAgent(Agent agent) async {
    return await _agentCollection.document(agent.id).setData(agent.toSnapshot());
  }

  @override
  Future<void> postAgents(List<Agent> agents) async {
    final batch = db.batch();
    for (var agent in agents) {
      var dataRef = _agentCollection.document(agent.id);
      batch.setData(dataRef, agent.toSnapshot());
    }
    return await batch.commit();
  }

  @override
  Future<List<DocumentSnapshot>> fetchAgents() async {
    final querySnapshot = await _agentCollection.getDocuments();
    final documents = querySnapshot.documents;
    return documents;
  }
}