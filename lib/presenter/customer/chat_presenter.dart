import 'package:tugas_akhir/data/chat/chat_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class ChatViewContract {
  void onLoadChatComplete(List<Chat> chats);
  void onLoadChatError();
}

class ChatPresenter {
  ChatViewContract _view;
  ChatRepository _repository;

  ChatPresenter(this._view) {
    _repository = new Injector().chatRepository;
  }

  void loadChats() {
    _repository.fetchChats()
        .then((chats) => _view.onLoadChatComplete(chats))
        .catchError((onError) => _view.onLoadChatError());
  }
}