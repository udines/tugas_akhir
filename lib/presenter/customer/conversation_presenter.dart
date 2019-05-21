import 'package:tugas_akhir/data/conversation/conversation_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class ConversationViewContract {
  void onLoadConversationComplete(List<Conversation> conversations);
  void onLoadConversationError();
}

class ConversationPresenter {
  ConversationViewContract _view;
  ConversationRepository _repository;

  ConversationPresenter(this._view) {
    _repository = new Injector().conversationRepository;
  }

  void loadConversations() {
    _repository.fetchConversations()
        .then((conversations) => _view.onLoadConversationComplete(conversations))
        .catchError((onError) => _view.onLoadConversationError());
  }
}