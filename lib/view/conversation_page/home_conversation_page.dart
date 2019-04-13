import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_akhir/data/conversation_data.dart';
import 'package:tugas_akhir/presenter/conversation_presenter.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => new _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> implements ConversationViewContract{
  ConversationPresenter _presenter;
  List<Conversation> _conversations;
  bool _isLoading;

  _ConversationPageState() {
    _presenter = new ConversationPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadConversations();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: _isLoading ?
        new Center(
          child: new CircularProgressIndicator(),
        ) : _conversationListContainer()
    );
  }

  Widget _conversationListContainer() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              itemCount: _conversations.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemConversation(_conversations[index]);
              },
            ),
          )
        ],
      )
    );
  }

  Widget _itemConversation(Conversation conversation) {
    return Center(
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 16, right: 16),
          title: Text(conversation.agent.name),
          subtitle: Text(conversation.lastMessage),
          onTap: () {},
        ),
      ),
    );
  }

  @override
  void onLoadConversationComplete(List<Conversation> conversations) {
    setState(() {
      _conversations = conversations;
      _isLoading = false;
    });
  }

  @override
  void onLoadConversationError() {
    Fluttertoast.showToast(
        msg: "Gagal memuat, coba lagi.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
  }
}