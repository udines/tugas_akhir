import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/agent_data_mock.dart';
import 'package:tugas_akhir/data/agent_data_prod.dart';
import 'package:tugas_akhir/data/barang_data.dart';
import 'package:tugas_akhir/data/barang_data_mock.dart';
import 'package:tugas_akhir/data/barang_data_prod.dart';
import 'package:tugas_akhir/data/chat_data.dart';
import 'package:tugas_akhir/data/chat_data_mock.dart';
import 'package:tugas_akhir/data/chat_data_prod.dart';
import 'package:tugas_akhir/data/conversation_data.dart';
import 'package:tugas_akhir/data/conversation_data_mock.dart';
import 'package:tugas_akhir/data/conversation_data_prod.dart';
import 'package:tugas_akhir/data/pickup_transaction_data.dart';
import 'package:tugas_akhir/data/pickup_transaction_data_mock.dart';
import 'package:tugas_akhir/data/pickup_transaction_data_prod.dart';
import 'package:tugas_akhir/data/transaction_data.dart';
import 'package:tugas_akhir/data/transaction_data_mock.dart';
import 'package:tugas_akhir/data/transaction_data_prod.dart';
import 'package:tugas_akhir/data/user_data.dart';
import 'package:tugas_akhir/data/user_data_mock.dart';
import 'package:tugas_akhir/data/user_data_prod.dart';

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

  AgentRepository get agentRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockAgentRepository();
      default:
        return new ProdAgentRepository();
    }
  }

  BarangRepository get barangRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockBarangRepository();
      default:
        return new ProdBarangRepository();
    }
  }

  ChatRepository get chatRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockChatRepository();
      default:
        return new ProdChatRepository();
    }
  }

  ConversationRepository get conversationRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockConversationRepository();
      default:
        return new ProdConversationRepository();
    }
  }

  PickupTransactionRepository get pickupTransaction {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockPickupTransactionRepository();
      default:
        return new ProdPickupTransactionRepository();
    }
  }

  TransactionRepository get transactionRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockTransactionRepository();
      default:
        return new ProdTransactionRepository();
    }
  }

  UserRepository get userRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockUserRepository();
      default:
        return new ProdUserRepository();
    }
  }
}