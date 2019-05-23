import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/agent/agent_data_mock.dart';
import 'package:tugas_akhir/data/agent/agent_data_prod.dart';

class AgentMock extends MockAgentRepository {}
class AgentProd extends ProdAgentRepository {}

main () {
  group('mock agent testing', () {
    var mock = AgentMock();
    test('mock fetch agent', () async {
      var result = await mock.fetchAgent('agentId');
      expect(result, isInstanceOf<Agent>());
    });
    test('mock fetch agents', () async {
      var result = await mock.getAgents();
      expect(result, isInstanceOf<List<Agent>>());
    });
    test('mock fetch agents by city', () async {
      var result = await mock.fetchAgentsByCity('city');
      expect(result, isInstanceOf<List<Agent>>());
    });
  });
  group('production agent testing', () {
    var prod = AgentProd();
    test('prod fetch agent', () async {
      var result = await prod.fetchAgent('agentId');
      expect(result, isInstanceOf<Agent>());
    });
    test('prod fetch agents', () async {
      var result = await prod.getAgents();
      expect(result, isInstanceOf<List<Agent>>());
    });
    test('prod fetch agents by city', () async {
      var result = await prod.fetchAgentsByCity('city');
      expect(result, isInstanceOf<List<Agent>>());
    });
    test('prod fetch agent failed', () async {
      var result = await prod.fetchAgent('agentIdFake');
      expect(result, throwsException);
    });
    test('prod fetch agents failed', () async {
      var result = await prod.getAgents();
      expect(result, throwsException);
    });
    test('prod fetch agents by city failed', () async {
      var result = await prod.fetchAgentsByCity('cityFake');
      expect(result, throwsException);
    });
  });
}