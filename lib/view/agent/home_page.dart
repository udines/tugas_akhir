import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/agent/home_presenter.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeViewContract {
  bool _isLoading;
  List<Pickup> _pickups;
  HomePresenter _presenter;
  User _user;

  _HomePageState() {
    _presenter = HomePresenter(this);
  }

  @override
  void initState() {
    _isLoading = true;
    _presenter.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agen Pos'),),
      body: Container(
        child: _isLoading ?
        new Center(
          child: new CircularProgressIndicator(),
        ) : _transactionListContainer(),
      ),
    );
  }

  Widget _transactionListContainer() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              itemCount: _pickups.length,
              itemBuilder: (BuildContext context, int index) {
                return _cardPickup(_pickups[index]);
              },
            ),
          )
        ],
      )
    );
  }

  Widget _cardPickup(Pickup pickup) {
    String _address = pickup.user.address;
    String _phone = pickup.user.phone;
    return Card(
      margin: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Tanggal penjemputan', style: TextStyle(color: Colors.grey),),
            Text(pickup.getStringDate(), style: TextStyle(fontSize: 16, color: Colors.black),),
            SizedBox(height: 8,),
            Text('Status', style: TextStyle(color: Colors.grey),),
            Text(pickup.status, style: TextStyle(fontSize: 16, color: Colors.black),),
            SizedBox(height: 8,),
            Text('Pengguna', style: TextStyle(color: Colors.grey),),
            Text(pickup.user.name, style: TextStyle(fontSize: 16, color: Colors.black),),
            Text("$_address ($_phone)", style: TextStyle(fontSize: 16, color: Colors.black),),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text("Lihat barang"),
                  textColor: Colors.blueAccent,
                  onPressed: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionListPage(pickupId: pickup.id,)
                        )
                    );*/
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void onGetCurrentUserComplete(User user) {
    setState(() {
      _user = user;
    });
    _presenter.loadPickupTransactions(_user.agentId);
  }

  @override
  void onGetCurrentUserError() {
    Fluttertoast.showToast(
        msg: 'Gagal memuat data pengguna',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0
    );
  }

  @override
  void onLoadPickupTransactionComplete(List<Pickup> pickups) {
    setState(() {
      _pickups = pickups;
    });
  }

  @override
  void onLoadPickupTransactionError() {
    Fluttertoast.showToast(
        msg: 'Gagal memuat transaksi',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0
    );
  }
}