import 'package:flutter/material.dart';
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
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
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
    _presenter.loadPickupTransactions(_user.id);
  }

  @override
  void onGetCurrentUserError() {
    // TODO: implement onGetCurrentUserError
  }

  @override
  void onLoadPickupTransactionComplete(List<Pickup> pickups) {
    setState(() {
      _pickups = pickups;
    });
  }

  @override
  void onLoadPickupTransactionError() {
    // TODO: implement onLoadPickupTransactionError
  }
}