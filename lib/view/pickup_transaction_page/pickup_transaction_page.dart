import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir/data/pickup_transaction_data.dart';
import 'package:tugas_akhir/data/user_data.dart';
import 'package:tugas_akhir/presenter/pickup_transaction_presenter.dart';

class PickupTransactionPage extends StatefulWidget{
  final User user;

  PickupTransactionPage({Key key, this.user});

  @override
  _PickupTransactionState createState() => new _PickupTransactionState();
}

class _PickupTransactionState extends State<PickupTransactionPage> implements PickupTransactionViewContract {
  PickupTransactionPresenter _presenter;
  List<PickupTransaction> _pickups;
  bool _isLoading;

  _PickupTransactionState() {
    _presenter = new PickupTransactionPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadPickupTransactionsUser(widget.user.id);
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

  Widget _itemPickupTransaction(PickupTransaction pickup) {
    return Card(
      margin: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Padding(
        padding: EdgeInsets.only(top: 12),
        child: Column(
          children: <Widget>[
            Text(
              new DateFormat.yMMMMd().format(pickup.date), 
              style: TextStyle(fontSize: 18)
            ),
            ListTile(
              title: Text(pickup.agent.name),
              subtitle: Text(pickup.agent.address),
            ),
            ListTile(
              title: Text("3KM 10KG"),
              subtitle: Text("Rp.100.000"),
            ),
            ListTile(
              title: Text(pickup.user.name),
              subtitle: Text(pickup.user.address),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text("Lihat barang"),
                  textColor: Colors.blueAccent,
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void onLoadPickupTransactionComplete(List<PickupTransaction> pickups) {
    setState(() {
      _isLoading = false;
      _pickups = pickups;
    });
  }

  @override
  void onLoadPickupTransactionError() {

  }
}