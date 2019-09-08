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
          _addAgents();
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

  _addAgents() {
    List<Agent> agents = [];
    Agent agent = Agent();
    agent.geoPoint = GeoPoint(
      -7.774873, 110.374674
    );
    agent.id = 'newAgentI';
    agent.address = 'Jl. Bulaksumur Blk. H No.3, Blimbing Sari, Caturtunggal, Kec. Depok, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55281';
    agent.name = 'Kantor Pos Bulaksumur UGM';
    agent.phone = '(0274) 589709';
    agent.timeClose = '16:30';
    agent.timeOpen = '07:30';
    agent.adminId = 'q9UWqpsOAuNIhreGZT6BphEQrDj2';
    agents.add(agent);

    agent = Agent();
    agent.geoPoint = GeoPoint(
      -7.731925, 110.378536
    );
    agent.id = 'newAgentJ';
    agent.address = 'Jl. Palagan Tentara Pelajar, Karang Moko, Sariharjo, Kec. Ngaglik, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55581';
    agent.name = 'Kantor Pos Palagan';
    agent.phone = '(0274) 4533307';
    agent.timeClose = '16:00';
    agent.timeOpen = '08:00';
    agent.adminId = 'q9UWqpsOAuNIhreGZT6BphEQrDj2';
    agents.add(agent);

    agent = Agent();
    agent.geoPoint = GeoPoint(
      -7.733498, 110.368966
    );
    agent.id = 'newAgentK';
    agent.address = 'Jalan Magelang, Jl. Prawiro Sudiyono Jl. Jongke Kidul No.204, Jongke Tengah, Sendangadi, Kec. Mlati, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55285';
    agent.name = 'Agen POS MARGOLUWIH';
    agent.phone = '0813-9251-5507';
    agent.timeClose = '24:00';
    agent.timeOpen = '00:00';
    agent.adminId = 'q9UWqpsOAuNIhreGZT6BphEQrDj2';
    agents.add(agent);

    agent = Agent();
    agent.geoPoint = GeoPoint(
      -7.757078, 110.369638
    );
    agent.id = 'newAgentL';
    agent.address = 'Jl. Monumen Jogja Kembali No.66, 49, Sinduadi, Kec. Mlati, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55284';
    agent.name = 'Kantor Pos';
    agent.phone = '(0274) 624990';
    agent.timeClose = '18:00';
    agent.timeOpen = '09:00';
    agent.adminId = 'q9UWqpsOAuNIhreGZT6BphEQrDj2';
    agents.add(agent);

    agent = Agent();
    agent.geoPoint = GeoPoint(
      -7.763546, 110.379341
    );
    agent.id = 'newAgentM';
    agent.address = 'Kaliurang St Blok CT3 No.17, Kocoran, Caturtunggal, Depok Sub-District, Sleman Regency, Special Region of Yogyakarta 55281';
    agent.name = 'Kantor Pos Kocoran';
    agent.phone = '0813-9205-0124';
    agent.timeClose = '20:00';
    agent.timeOpen = '08:00';
    agent.adminId = 'q9UWqpsOAuNIhreGZT6BphEQrDj2';
    agents.add(agent);

    _presenter.addAgents(agents);
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