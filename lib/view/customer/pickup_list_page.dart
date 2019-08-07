import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/presenter/customer/pickup_list_presenter.dart';
import 'package:tugas_akhir/view/customer/transaction_list_page.dart';

class PickupListPage extends StatefulWidget{
  @override
  _PickupListState createState() => new _PickupListState();
}

class _PickupListState extends State<PickupListPage> implements PickupViewContract {
  PickupPresenter _presenter;
  List<Pickup> _pickups;
  bool _isLoading;

  _PickupListState() {
    _presenter = PickupPresenter(this);
    _presenter.loadPickupsByUser();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _isLoading ?
        Center(
          child: CircularProgressIndicator(),
        ) : _pickupListContainer()
    );
  }

  Widget _pickupListContainer() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              itemCount: _pickups.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemPickupTransaction(_pickups[index]);
              },
            ),
          )
        ],
      )
    );
  }

  Widget _itemPickupTransaction(Pickup pickup) {
    String _address = pickup.agent.address;
    String _phone = pickup.agent.phone;
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
            Text('Agen', style: TextStyle(color: Colors.grey),),
            Text(pickup.agent.name, style: TextStyle(fontSize: 16, color: Colors.black),),
            Text("$_address ($_phone)", style: TextStyle(fontSize: 16, color: Colors.black),),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text("Lihat barang"),
                  textColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionListPage(pickupId: pickup.id,)
                      )
                    );
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
  void onLoadPickupTransactionComplete(List<Pickup> pickups) {
    setState(() {
      _isLoading = false;
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