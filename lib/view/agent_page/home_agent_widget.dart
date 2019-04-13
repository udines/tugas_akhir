import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/presenter/agent_presenter.dart';

class AgentPage extends StatefulWidget {
  @override
  _AgentPageState createState() => new _AgentPageState();
}

class _AgentPageState extends State<AgentPage> implements AgentViewContract {
  AgentPresenter _presenter;
  List<Agent> _agents;
  bool _isLoading;

  _AgentPageState() {
    _presenter = new AgentPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadAgents();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: _isLoading ?
          new Center(
            child: new CircularProgressIndicator(),
          )
          : _agentListContainer()
    );
  }

  Widget _agentListContainer() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              itemCount: _agents.length,
              itemBuilder: (BuildContext context, int index) {
                return _cardAgent(_agents[index]);
              },
            ),
          )
        ],
      )
    );
  }

  Widget _cardAgent(Agent agent) {
    String _address = agent.address;
    String _phone = agent.phone;
    String _timeOpen = agent.timeOpen;
    String _timeClose = agent.timeClose;

    return Center(
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  title: Text(agent.name),
                  subtitle: Text("$_address ($_phone)\nBuka jam $_timeOpen - $_timeClose")
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {},
                      label: Text("Telpon"),
                      icon: new Icon(Icons.phone),
                    ),
                    FlatButton.icon(
                      onPressed: () {},
                      label: Text("Pesan"),
                      icon: new Icon(Icons.message),
                    ),
                    FlatButton.icon(
                      onPressed: () {},
                      label: Text("Arah"),
                      icon: new Icon(Icons.directions),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  @override
  void onLoadAgentComplete(List<Agent> agents) {
    setState(() {
      _agents = agents;
      _isLoading = false;
    });
  }

  @override
  void onLoadAgentError() {
    // TODO: implement onLoadAgentError
    //hehe
  }

}