class Chat {
  String id;
  String message;
  bool isSentByUser;
  DateTime date;
  //Relations
  String idAgent;
  String idConversation;
  String idUser;

  Chat({
    this.id,
    this.message,
    this.isSentByUser,
    this.date,
    this.idAgent,
    this.idConversation,
    this.idUser
  });
}

abstract class ChatRepository {
  Future<List<Chat>> fetchChats();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}