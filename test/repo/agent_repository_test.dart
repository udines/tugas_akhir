import 'package:flutter_test/flutter_test.dart';
import 'package:latlong/latlong.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/agent/agent_data_mock.dart';
import 'package:tugas_akhir/data/agent/agent_data_prod.dart';

class AgentMock extends MockAgentRepository {}
class AgentProd extends ProdAgentRepository {}

main () {
  group('mock agent testing', () {
    var mock = AgentMock();

    double calculateDistance(double latA, double longA, double latB, double longB) {
      final Distance distance = Distance();
      return distance.as(
          LengthUnit.Kilometer,
          LatLng(latA, longA),
          LatLng(latB, longB)
      );
    }

    test('mock fetch agent match param id', () async {
      var agentId = 'agentId';
      var agent = await mock.fetchAgent(agentId);
      var result = agent.id == agentId;
      expect(result, true);
    });

    test('mock fetch nearby agents within radius', () async {
      double radius = 30;
      double lat = -7.821251;
      double long = 110.417633;

      List<Agent> agents = await mock.fetchAgentsNearby(lat, long, radius);
      var result = true;
      for (var agent in agents) {
        if (calculateDistance(lat, long, agent.geoPoint.latitude, agent.geoPoint.longitude) <= radius) {
          result = result && true;
        } else {
          result = result && false;
        }
      }
      expect(result, true);
    });

    test('mock fetch nearby agents sorted by distance', () async {
      double radius = 30;
      double lat = -7.821251;
      double long = 110.417633;

      List<Agent> agents = await mock.fetchAgentsNearby(lat, long, radius);
      var result = true;
      var distance = calculateDistance(lat, long, agents[0].geoPoint.latitude, agents[0].geoPoint.longitude);
      var nextDistance;

      for (var i = 0; i < agents.length - 1; i++) {
        distance = calculateDistance(lat, long, agents[i].geoPoint.latitude, agents[i].geoPoint.longitude);
        nextDistance = calculateDistance(lat, long, agents[i + 1].geoPoint.latitude, agents[i + 1].geoPoint.longitude);
        if (distance <= nextDistance) {
          result = result && true;
        } else {
          result = result && false;
        }
      }
      expect(result, true);
    });

  });
}