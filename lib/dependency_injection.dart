import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/agent/agent_data_mock.dart';
import 'package:tugas_akhir/data/agent/agent_data_prod.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/data/location/location_data_mock.dart';
import 'package:tugas_akhir/data/location/location_data_prod.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/pickup/pickup_data_mock.dart';
import 'package:tugas_akhir/data/pickup/pickup_data_prod.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data_mock.dart';
import 'package:tugas_akhir/data/transaction/transaction_data_prod.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/data/user/user_data_mock.dart';
import 'package:tugas_akhir/data/user/user_data_prod.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  AgentRepository get agentRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockAgentRepository();
      default:
        return ProdAgentRepository();
    }
  }

  PickupRepository get pickupRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockPickupRepository();
      default:
        return ProdPickupRepository();
    }
  }

  TransactionRepository get transactionRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockTransactionRepository();
      default:
        return ProdTransactionRepository();
    }
  }

  UserRepository get userRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockUserRepository();
      default:
        return ProdUserRepository();
    }
  }

  LocationRepository get locationRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockLocationRepository();
      default:
        return ProdLocationRepository();
    }
  }
}