import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/transaction_data.dart';
import 'package:tugas_akhir/data/user_data.dart';
import 'package:tugas_akhir/presenter/order_input_presenter.dart';
import 'package:tugas_akhir/view/add_item_page/add_item_page.dart';

class OrderInputPage extends StatefulWidget {
  final Agent agent;
  final User user;

  OrderInputPage({Key key, this.agent, this.user}) : super(key: key);

  @override
  _OrderInputPageState createState() => _OrderInputPageState();
}

class _OrderInputPageState extends State<OrderInputPage> implements OrderInputViewContract{

  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  CameraPosition _cameraPosition;
  bool _isLoading;
  OrderInputPresenter _presenter;
  double zoom = 14.4746;
  String _address;
  List<Transaction> _transactions = [];

  _OrderInputPageState() {
    _presenter = OrderInputPresenter(this);
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
                    child: RaisedButton(
                      child: Text(
                        "Tambahkan Barang", 
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        _navigateToAddItemPage(context);
                      },
                    ),
                  )
                ]
              ),
            ),
          ],
        )
      ),
    );
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
      _transactions.add(result);
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
    String type = transaction.item.type;
    String weight = transaction.item.weight.toString() + "kg";
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              title: Text(transaction.item.name),
              subtitle: Text("$type $weight"),
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
  void onGetCurrentUserLocationError(String errorMessage) {
    // TODO: implement onGetCurrentUserLocationError
  }

  @override
  void onGetAddressComplete(String address) {
    setState(() {
      _address = address;
    });
  }

  @override
  void onGetAddressError(String errorMessage) {
    // TODO: implement onGetAddressError
  }
}