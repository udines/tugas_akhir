import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/agent_data_mock.dart';
import 'package:tugas_akhir/data/agent_data_prod.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  AgentRepository get agentRepository{
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockAgentRepository();
      default:
        return new ProdAgentRepository();
    }
  }
}