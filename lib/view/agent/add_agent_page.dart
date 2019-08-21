import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/presenter/agent/add_agent_presenter.dart';

class AddAgentPage extends StatefulWidget {
  @override
  _AddAgentPageState createState() => _AddAgentPageState();
}

class _AddAgentPageState extends State<AddAgentPage> implements AddAgentViewContract {

  AddAgentPresenter _presenter;

  _AddAgentPageState() {
    _presenter = AddAgentPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add agent'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final geoPoint = GeoPoint(
            -7.827481,
            110.400527
          );
          Agent agent = Agent();
          agent.geoPoint = geoPoint;
          agent.id = 'newAgentC';
          agent.address = 'Jl. Kemasan No. 1';
          agent.name = 'Kantorpos Yogyakarta Kotagede';
          agent.phone = '02743994632';
          agent.timeClose = '15:00';
          agent.timeOpen = '09:00';
          agent.adminId = 'q9UWqpsOAuNIhreGZT6BphEQrDj2';
          _presenter.addAgent(agent);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }

  @override
  void onAddAgentFail() {
    // TODO: implement onAddAgentFail
  }

  @override
  void onAddAgentSuccess() {
    // TODO: implement onAddAgentSuccess
  }
}