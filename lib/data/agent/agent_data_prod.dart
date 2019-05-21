import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      agent = agentSnaps.data as Agent;
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
}