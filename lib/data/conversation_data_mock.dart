import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

import 'conversation_data.dart';

class MockConversationRepository implements ConversationRepository {
  @override
  Future<List<Conversation>> fetchConversations() {
    return Future.value(conversations);
  }
}

var conversations = <Conversation>[
  new Conversation(
    id: "conversationA",
    isReadByAgent: true,
    isReadByUser: false,
    date: new DateTime.now(),
    lastMessage: "Mmm, I work in convenience store right now",
    user: new User(
      id: "userA",
      name: "Farhan",
      address: "Jalan Sukabirus No. 418",
      phone: "08976378464"
    ),
    agent: new Agent(
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
    idAgent: "agentA",
    idUser: "userA"
  ),
  new Conversation(
    id: "conversationB",
    isReadByAgent: false,
    isReadByUser: false,
    date: new DateTime.now(),
    user: new User(
      id: "userA",
      name: "Farhan",
      address: "Jalan Sukabirus No. 418",
      phone: "08976378464"
    ),
    agent: new Agent(
      id: "agentB",
      address: "Baturetno, Banguntapan",
      costPerKM: 1000,
      costPerKG: 1000,
      isReceiveOrder: true,
      name: "Agenpos Kotagede",
      phone: "0224207081",
      timeOpen: "07:00",
      timeClose: "19:00",
      latitude: -7.821813,
      longitude: 110.417288,
      userAdmin: new User(
        id: "userAgentB",
        name: "Pranowo",
        address: "Wiyoro Banguntapan",
        phone: "08978873886"
      )
    ),
    lastMessage: "Hehehe",
    idAgent: "agentB",
    idUser: "userB"
  ),
];