import 'package:tugas_akhir/data/agent_data.dart';
import 'user_data.dart';

class Conversation {
  String id;
  bool isReadByAgent;
  bool isReadByUser;
  DateTime date;
  String lastMessage;
  //Relations
  Agent agent;
  User user;
  String idAgent;
  String idUser;

  Conversation({
    this.id,
    this.isReadByAgent,
    this.isReadByUser,
    this.date,
    this.lastMessage,
    this.agent,
    this.user,
    this.idAgent,
    this.idUser
  });
}

abstract class ConversationRepository {
  Future<List<Conversation>> fetchConversations();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}