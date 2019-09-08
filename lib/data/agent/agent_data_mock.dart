import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';

class MockAgentRepository implements AgentRepository {

  @override
  Future<Agent> fetchAgent(String agentId) {
    return Future.value(
      agents.firstWhere(
          (agent) => agent.id == agentId
      )
    );
  }

  @override
  Future<List<Agent>> fetchAgentsNearby(double latitude, double longitude, double radius) {
    return Future.value(agents);
  }

  @override
  Future<void> postAgent(Agent agent) {
    return Future.value(true);
  }

  @override
  Future<void> postAgents(List<Agent> agents) {
    return Future.value(true);
  }
}

var agents = <Agent>[
  Agent(
    id: "agentA",
    address: "Baturetno, Banguntapan",
    isReceiveOrder: true,
    name: "Agenpos Jogoragan",
    phone: "0224207081",
    timeOpen: "07:00",
    timeClose: "19:00",
    geoPoint: GeoPoint(-7.821813, 110.417288),
    adminId: 'userA'
  ),
  Agent(
    id: "agentB",
    address: "Jl. Sorogenen No. 1",
    isReceiveOrder: false,
    name: "Post Office Sorogenen",
    phone: "02749171179",
    timeOpen: "07:00",
    timeClose: "21:00",
    geoPoint: GeoPoint(-7.828114, 110.406007),
    adminId: 'userB'
  ),
  Agent(
    id: "agentC",
    address: "Jl. Kemasan No. 1",
    isReceiveOrder: true,
    name: "Kantorpos Yogyakarta Kotagede",
    phone: "02743994632",
    timeOpen: "09:00",
    timeClose: "15:00",
    geoPoint: GeoPoint(-7.827481, 110.400527),
    adminId: 'userC'
  )
];