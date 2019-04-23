import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/user_data.dart';

class OrderInputPage extends StatefulWidget {
  final Agent agent;
  final User user;

  OrderInputPage({Key key, this.agent, this.user}) : super(key: key);

  @override
  _OrderInputPageState createState() => _OrderInputPageState();
}

class _OrderInputPageState extends State<OrderInputPage> {

  _OrderInputPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesan Penjemputan"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Alamat penjemputan"),
            TextFormField(initialValue: widget.user.address,),
            Text("Lokasi"),
            //Google map
            Text(widget.agent.name),
            Text(widget.agent.address),
            Text("Daftar barang"),
            //list view
            ButtonTheme.bar(
              child: RaisedButton(
                child: Text(
                  "Tambahkan Barang", 
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}