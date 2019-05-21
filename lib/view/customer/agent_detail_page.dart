import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/view/customer/input_pickup_page.dart';
import 'package:tugas_akhir/presenter/customer/agent_detail_presenter.dart';

class AgentDetailPage extends StatefulWidget {
  final Agent agent;

  AgentDetailPage({Key key, @required this.agent}) : super(key: key);

  @override
  _AgentDetailPageState createState() => _AgentDetailPageState();
}

class _AgentDetailPageState extends State<AgentDetailPage> implements AgentDetailViewContract {
  BuildContext context;
  AgentDetailPresenter _presenter;
  User _currentUser;

  _AgentDetailPageState() {
    _presenter = AgentDetailPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agent.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //alamat dan jam buka/tutup
              Text("Alamat", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              Text(widget.agent.address, style: TextStyle(fontSize: 16, color: Colors.black)),
              Padding(padding: EdgeInsets.only(top: 16),),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Jam buka", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(widget.agent.timeOpen, style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 32),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Jam tutup", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(widget.agent.timeClose, style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                ],
              ),
              //peta kecil dengan rute dari lokasi pengguna ke lokasi agen

              Padding(padding: EdgeInsets.only(top: 16),),
              //no telepon dan button telepon & chat
              Text("Nomor telepon", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              Text(widget.agent.phone, style: TextStyle(fontSize: 16, color: Colors.black)),
              ButtonTheme.bar(
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      child: Text("Telepon"),
                    ),
                  ],
                ),
              ),

              //fitur menerima pesanan jemput dan tarif
              Padding(padding: EdgeInsets.only(top: 16),),
              Text("Menerima penjemputan", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              _receiveOrder(widget.agent.isReceiveOrder),

              Padding(padding: EdgeInsets.only(top: 16),),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Tarif per KM", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(widget.agent.costPerKM.toString(), style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 32),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Tarif per KG", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(widget.agent.costPerKG.toString(), style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 16),),
              ButtonTheme.bar(
                child: RaisedButton(
                  onPressed: () {
                    _goToOrderInputPage(widget.agent);
                  },
                  child: Text("Pesan Penjemputan", style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goToOrderInputPage(Agent agent) {
    if(agent != null && _currentUser != null) {
      if(_presenter.isAgentOpen(agent, DateTime.now())) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InputPickupPage(
              agent: agent,
              user: _currentUser,
            )
          )
        );
      } else {
        //Agen sedang tutup
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Agen tutup')));
      }
    } else {
      //data agen atau pengguna tidak ada
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Tidak ditemukan data agen atau data pengguna')
        )
      );
    }
  }

  Widget _receiveOrder(bool isReceiveOrder) {
    var text = "";
    if(isReceiveOrder) {
      text = "YA";
    } else {
      text = "TIDAK";
    }
    return Text(text, style: TextStyle(
      fontSize: 16, 
      color: Colors.black, 
      fontWeight: FontWeight.w800
      )
    );
  }

  @override
  void onGetCurrentUserComplete(User user) {
    setState(() {
      _currentUser = user;
    });
  }

  @override
  void onGetCurrentUserError() {
    // TODO: implement onGetCurrentUserError
  }

  @override
  void onLoadAgentComplete(Agent agent) {
    // TODO: implement onLoadAgentComplete
  }

  @override
  void onLoadAgentError() {
    // TODO: implement onLoadAgentError
  }
}