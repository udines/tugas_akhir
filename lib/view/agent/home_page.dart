import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/agent/home_presenter.dart';
import 'package:tugas_akhir/view/agent/transaction_list_page.dart';
import 'package:tugas_akhir/view/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeViewContract {
  bool _isLoading;
  List<Pickup> _pickups = [];
  HomePresenter _presenter;
  User _user;
  String _agentId;

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
      appBar: AppBar(
        title: Text('Agen Pos'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _presenter.logoutUser();
            },
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => AddAgentPage())
          );
        },
      ),*/
      body: Container(
        child: _isLoading ?
        Center(
          child: CircularProgressIndicator(),
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
            Text('Tanggal pemesanan', style: TextStyle(color: Colors.grey),),
            Text(pickup.getStringDate(), style: TextStyle(fontSize: 16, color: Colors.black),),
            SizedBox(height: 8,),
            Text('Status', style: TextStyle(color: Colors.grey),),
            Text(pickup.status, style: TextStyle(fontSize: 16, color: Colors.black),),
            SizedBox(height: 8,),
            Text('Pelanggan', style: TextStyle(color: Colors.grey),),
            Text(pickup.user.name, style: TextStyle(fontSize: 16, color: Colors.black),),
            Text("$_address ($_phone)", style: TextStyle(fontSize: 16, color: Colors.black),),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text("Navigasi"),
                  textColor: Colors.blueAccent,
                  onPressed: () {
                    _openMapNavigation(
                      pickup.geoPoint.latitude, 
                      pickup.geoPoint.longitude
                    );
                  },
                ),
                FlatButton(
                  child: Text("Status"),
                  textColor: Colors.blueAccent,
                  onPressed: () {
                    _showStatusDialog(pickup.id);
                  },
                ),
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _openMapNavigation(double desLat, double desLng) async {
    var url = 'google.navigation:q=$desLat,$desLng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _showStatusDialog(String pickupId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ubah Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _presenter.updateStatus(Pickup.STATUS_PROCESS, pickupId);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(Pickup.STATUS_PROCESS),
                )
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _presenter.updateStatus(Pickup.STATUS_COMPLETED, pickupId);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(Pickup.STATUS_COMPLETED),
                )
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _presenter.updateStatus(Pickup.STATUS_CANCEL, pickupId);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(Pickup.STATUS_CANCEL),
                )
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  void onGetCurrentUserComplete(User user) {
    setState(() {
      _user = user;
    });
    _agentId = user.agentId;
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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLogoutSuccess() {
    _presenter.clearPreferences();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage())
    );
  }

  @override
  void onUpdateStatusSuccess() {
    _presenter.loadPickupTransactions(_agentId);
  }
}