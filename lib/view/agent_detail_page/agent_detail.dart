import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/agent_data.dart';

class AgentDetail extends StatelessWidget {
  final Agent agent;
  BuildContext context;

  AgentDetail({Key key, @required this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(agent.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //alamat dan jam buka/tutup
              Text("Alamat", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              Text(agent.address, style: TextStyle(fontSize: 16, color: Colors.black)),
              Padding(padding: EdgeInsets.only(top: 16),),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Jam buka", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(agent.timeOpen, style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 32),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Jam tutup", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(agent.timeClose, style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                ],
              ),
              //peta kecil dengan rute dari lokasi pengguna ke lokasi agen

              Padding(padding: EdgeInsets.only(top: 16),),
              //no telepon dan button telepon & chat
              Text("Nomor telepon", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              Text(agent.phone, style: TextStyle(fontSize: 16, color: Colors.black)),
              ButtonTheme.bar(
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      child: Text("Telepon"),
                    ),
                    Padding(padding: EdgeInsets.only(left: 16),),
                    RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      child: Text("Kirim Pesan"),
                    )
                  ],
                ),
              ),

              //fitur menerima pesanan jemput dan tarif
              Padding(padding: EdgeInsets.only(top: 16),),
              Text("Menerima penjemputan", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              _receiveOrder(agent.isReceiveOrder),

              Padding(padding: EdgeInsets.only(top: 16),),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Tarif per KM", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(agent.costPerKM.toString(), style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 32),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Tarif per KG", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(agent.costPerKG.toString(), style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 16),),
              ButtonTheme.bar(
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("Pesan Penjemputan", style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
}