import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/presenter/customer/agent_list_presenter.dart';
import 'package:tugas_akhir/view/customer/agent_detail_page.dart';

class AgentListPage extends StatefulWidget {
  @override
  _AgentListPageState createState() => new _AgentListPageState();
}

class _AgentListPageState extends State<AgentListPage> implements AgentListViewContract {
  AgentListPresenter _presenter;
  List<Agent> _agents;
  bool _isLoading;
  double _latitude;
  double _longitude;

  _AgentListPageState() {
    _presenter = new AgentListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: _isLoading ?
      Center(
        child: new CircularProgressIndicator(),
      ) : _agentListContainer()
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
                onTap: () {
                  _onItemTapped(agent);
                },
                title: Text(agent.name),
                subtitle: Text("$_address ($_phone)\nBuka jam $_timeOpen - $_timeClose")
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {
                        _makePhoneCall(agent.phone);
                      },
                      label: Text("Telepon"),
                      icon: Icon(Icons.phone),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        _openMapNavigation(agent.geoPoint.latitude, agent.geoPoint.longitude);
                      },
                      label: Text("Arah"),
                      icon: Icon(Icons.directions),
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

  void _makePhoneCall(String phone) async {
    var url = "tel:" + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openMapNavigation(double desLat, double desLng) async {
    var url = 'google.navigation:q=$desLat,$desLng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(Agent agent) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentDetailPage(
          agent: agent
        )
      )
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

  }

  @override
  void onGetCurrentUserLocationComplete(double latitude, double longitude) {
   _presenter.fetchAgentsNearby(latitude, longitude, 100);
   _latitude = latitude;
   _longitude = longitude;
  }

  @override
  void onLocationPermissionDenied() {
    _presenter.requestLocationPermission();
  }

  @override
  void onLocationPermissionGranted() {
    _presenter.getUserCurrentLocation();
  }

}