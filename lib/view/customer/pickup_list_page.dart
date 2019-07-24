import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/presenter/customer/pickup_list_presenter.dart';
import 'package:tugas_akhir/view/customer/item_list_page.dart';

class PickupListPage extends StatefulWidget{
  @override
  _PickupListState createState() => new _PickupListState();
}

class _PickupListState extends State<PickupListPage> implements PickupViewContract {
  PickupPresenter _presenter;
  List<Pickup> _pickups;
  bool _isLoading;

  _PickupListState() {
    _presenter = new PickupPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadPickupsByUser("userId");
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: _isLoading ?
        new Center(
          child: new CircularProgressIndicator(),
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
    return Card(
      margin: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '',
              style: TextStyle(fontSize: 18)
            ),
            SizedBox(height: 8,),
            Text(
              'Agen',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4,),
            SizedBox(height: 8,),
            Text(
              'Tarif',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4,),
            Text("3km 10kg"),
            Text("Rp.100.000"),
            SizedBox(height: 8,),
            Text(
              'Pengguna',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4,),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text("Lihat barang"),
                  textColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemListPage()
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

  }
}