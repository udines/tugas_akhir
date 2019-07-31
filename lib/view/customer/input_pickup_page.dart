import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/customer/input_pickup_presenter.dart';
import 'package:tugas_akhir/view/customer/add_item_page.dart';

class InputPickupPage extends StatefulWidget {
  final Agent agent;
  final User user;

  InputPickupPage({Key key, this.agent, this.user}) : super(key: key);

  @override
  _InputPickupPageState createState() => _InputPickupPageState();
}

class _InputPickupPageState extends State<InputPickupPage> implements InputPickupViewContract{

  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  CameraPosition _cameraPosition;
  bool _isLoading;
  InputPickupPresenter _presenter;
  LatLng _location;
  double zoom = 14.4746;
  String _address;
  List<Transaction> _transactions = [];

  _InputPickupPageState() {
    _presenter = InputPickupPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.getUserCurrentLocation();
    _address = widget.user.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesan Penjemputan"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text("Lokasi penjemputan"),
                  SizedBox(height: 8,),
                  //Google map
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: _isLoading ?
                    new Center(
                      child: new CircularProgressIndicator(),
                    ) : _mapContainer(),
                  ),
                  SizedBox(height: 8,),
                  Text("Alamat penjemputan"),
                  TextFormField(initialValue: _address),
                  SizedBox(height: 16,),
                  Text(widget.agent.name, 
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(widget.agent.address),
                  SizedBox(height: 16,),
                  Text("Daftar barang",
                    style: TextStyle(fontSize: 16),
                  ),
                ]
              ),
            ),
            
            //list view
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (_transactions.length > 0) {
                    return _itemCard(_transactions[index], index);
                  } else {
                    return SizedBox();
                  }
                },
                childCount: _transactions.length
              )
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ButtonTheme.bar(
                    child: FlatButton(
                      child: Text(
                        "+ Tambahkan Barang", 
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ),
                      onPressed: () {
                        _navigateToAddItemPage(context);
                      },
                    ),
                  ),
                  ButtonTheme.bar(
                    child: RaisedButton(
                      child: Text(
                        "PESAN SEKARANG", 
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        _sendData();
                      },
                    ),
                  ),
                ]
              ),
            ),
          ],
        )
      ),
    );
  }

  _sendData() {
    if (_transactions.length > 0) {
      Pickup pickup = Pickup(
        timestamp: fs.Timestamp.now(),
        geoPoint: fs.GeoPoint(_location.latitude, _location.longitude),
        status: Pickup.STATUS_WAITING,
        agentId: widget.agent.id,
        userId: widget.user.id
      );
      _presenter.postPickup(pickup);
    } else {
      Fluttertoast.showToast(
        msg: 'Tambahkan barang terlebih dahulu',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0
      );
    }
  }

  _navigateToAddItemPage(BuildContext context) async {
    final result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => AddItemPage(
          agent: widget.agent,
          user: widget.user,
        )
      )
    );

    setState(() {
      if (result != null) {
        _transactions.add(result);
      }
    });
  }

  Widget _mapContainer() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        if (!_controller.isCompleted) {
          _controller.complete(controller);
        }
      },
      markers: Set<Marker>.of(_markers.values),
    );
  }

  Widget _itemCard(Transaction transaction, int position) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              onTap: () {
                //go to detail item
              },
            ),
            ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        //delete item
                        setState(() {
                          _transactions.removeAt(position);
                        });
                      }, 
                      child: Text('Hapus'),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  void onGetCurrentUserLocationComplete(double latitude, double longitude) {
    _location = LatLng(latitude, longitude);
    var id = "Lokasi Pengguna";
    MarkerId markerId = MarkerId(id);
    Marker userMarker = Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: "Lokasi Anda",
      ),
      icon: BitmapDescriptor.defaultMarker
    );

    setState(() {
      _cameraPosition = new CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: zoom
      );
      _markers[markerId] = userMarker;
      _isLoading = false;
    });

    _presenter.getAddress(latitude, longitude);
  }

  @override
  void onGetAddressComplete(String address) {
    setState(() {
      _address = address;
    });
  }

  @override
  void onPostPickupSuccess(String pickupId) {
    for (int i = 0; i < _transactions.length; i++) {
      _transactions[i].pickupId = pickupId;
    }
    _presenter.postTransactions(_transactions);
  }

  @override
  void onPostTransactionsSuccess() {
    Fluttertoast.showToast(
      msg: 'Harap tunggu agen menerima pesanan Anda',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      fontSize: 16.0
    );
  }
}