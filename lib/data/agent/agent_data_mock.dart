import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

class MockAgentRepository implements AgentRepository {
  @override
  Future<List<Agent>> fetchAgentsByCity(String city) {
    return new Future.value(agents);
  }

  @override
  Future<Agent> fetchAgent(String agentId) {
    return new Future.value(
      new Agent(
        id: "agentC",
        address: "Jl. Kemasan No. 1",
        costPerKM: 2000,
        costPerKG: 1000,
        isReceiveOrder: true,
        name: "Kantorpos Yogyakarta Kotagede",
        phone: "02743994632",
        timeOpen: "09:00",
        timeClose: "15:00",
        latitude: -7.827481,
        longitude: 110.400527,
        userAdmin: new User(
          id: "userAgentC",
          name: "Somad",
          address: "Karanglo",
          phone: "08917327493"
        )
      )
    );
  }

  @override
  Future<List<Agent>> getAgents() {
    return new Future.value(agents);
  }
}

var agents = <Agent>[
  new Agent(
    id: "agentA",
    address: "Baturetno, Banguntapan",
    costPerKM: 1000,
    costPerKG: 1000,
    isReceiveOrder: true,
    name: "Agenpos Jogoragan",
    phone: "0224207081",
    timeOpen: "07:00",
    timeClose: "19:00",
    latitude: -7.821813,
    longitude: 110.417288,
    userAdmin: new User(
        id: "userAgentA",
        name: "Pranowo",
        address: "Wiyoro Banguntapan",
        phone: "08978873886"
    )
  ),
  new Agent(
      id: "agentB",
      address: "Jl. Sorogenen No. 1",
      costPerKM: 1000,
      costPerKG: 2000,
      isReceiveOrder: false,
      name: "Post Office Sorogenen",
      phone: "02749171179",
      timeOpen: "07:00",
      timeClose: "21:00",
      latitude: -7.828114,
      longitude: 110.406007,
      userAdmin: new User(
          id: "userAgentB",
          name: "Hamid",
          address: "Sorogenen",
          phone: "089619237368"
      )
  ),
  new Agent(
      id: "agentC",
      address: "Jl. Kemasan No. 1",
      costPerKM: 2000,
      costPerKG: 1000,
      isReceiveOrder: true,
      name: "Kantorpos Yogyakarta Kotagede",
      phone: "02743994632",
      timeOpen: "09:00",
      timeClose: "15:00",
      latitude: -7.827481,
      longitude: 110.400527,
      userAdmin: new User(
          id: "userAgentC",
          name: "Somad",
          address: "Karanglo",
          phone: "08917327493"
      )
  )
];