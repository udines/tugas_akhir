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
    idAgent: "agentA",
    idUser: "userA"
  ),
  new Conversation(
      id: "conversationB",
      isReadByAgent: false,
      isReadByUser: false,
      date: new DateTime.now(),
      idAgent: "agentB",
      idUser: "userB"
  ),
];