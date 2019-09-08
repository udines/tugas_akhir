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
  Future<List<Agent>> fetchAgentsNearby(double latitude, double longitude, double rad) async {
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);

    double radius = rad;
    String field = 'position';

    final documents = await geo.collection(collectionRef: _agentCollection)
    .within(center: center, radius: radius, field: field).first;
    return Agent.listFromSnapshots(documents);
  }

  @override
  Future<void> postAgent(Agent agent) async {
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint position = geo.point(
      latitude: agent.geoPoint.latitude,
      longitude: agent.geoPoint.longitude
    );
    _agentCollection.document(agent.id).setData(agent.toSnapshot())
      .then((onValue) {
        _agentCollection.document(agent.id).updateData({'position': position.data});
      });
  }

  @override
  Future<void> postAgents(List<Agent> agents) async {
    final batch = db.batch();
    Geoflutterfire geo = Geoflutterfire();
    for (var agent in agents) {
      var position = geo.point(
        latitude: agent.geoPoint.latitude,
        longitude: agent.geoPoint.longitude
      );
      var dataRef = _agentCollection.document(agent.id);
      batch.setData(dataRef, agent.toSnapshot());
      batch.updateData(dataRef, {'position': position.data});
    }
    return await batch.commit();
  }
}