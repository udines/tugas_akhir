import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/user_data.dart';
import 'package:tugas_akhir/presenter/order_input_presenter.dart';

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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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

  Widget _mapContainer() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: Set<Marker>.of(_markers.values),
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