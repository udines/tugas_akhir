class Conversation {
  String id;
  bool isReadByAgent;
  bool isReadByUser;
  DateTime date;
  //Relations
  String idAgent;
  String idUser;

  Conversation({
    this.id,
    this.isReadByAgent,
    this.isReadByUser,
    this.date,
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