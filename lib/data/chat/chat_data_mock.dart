import 'package:tugas_akhir/data/chat/chat_data.dart';

class MockChatRepository implements ChatRepository {
  @override
  Future<List<Chat>> fetchChats() {
    return new Future.value(chats);
  }
}

var chats = <Chat>[
  new Chat(
    id: "chatId1",
    message: "Hello, how are you?",
    isSentByUser: true,
    date: new DateTime.now(),
    idAgent: "agentA",
    idConversation: "conversationA",
    idUser: "userA"
  ),
  new Chat(
      id: "chatId2",
      message: "I'm fine thanks.",
      isSentByUser: false,
      date: new DateTime.now(),
      idAgent: "agentA",
      idConversation: "conversationA",
      idUser: "userA"
  ),
  new Chat(
      id: "chatId3",
      message: "So, what do you do for living?",
      isSentByUser: true,
      date: new DateTime.now(),
      idAgent: "agentA",
      idConversation: "conversationA",
      idUser: "userA"
  ),
  new Chat(
      id: "chatId4",
      message: "Mmm, I work in convenience store right now",
      isSentByUser: false,
      date: new DateTime.now(),
      idAgent: "agentA",
      idConversation: "conversationA",
      idUser: "userA"
  ),
];