import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/presenter/map_presenter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> implements MapViewContract {
  MapPresenter _presenter;
  List<Agent> _agents;
  bool _isLoading;
  LatLng _userLocation;
  CameraPosition _cameraPosition;
  double zoom = 14.4746;
  Completer<GoogleMapController> _controller = Completer();

  _MapPageState() {
    _presenter = MapPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: _isLoading ?
        new Center(
          child: new CircularProgressIndicator(),
        ) : _mapContainer()
    );
  }

  Widget _mapContainer() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  @override
  void onLoadAgentComplete(List<Agent> agents) {
    setState(() {
      _isLoading = false;
      _agents = agents;
    });
  }

  @override
  void onLoadAgentError() {
    Fluttertoast.showToast(
        msg: "Gagal memuat, coba lagi.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
  }

  @override
  void onGetCurrentUserLocationComplete(double latitude, double longitude) {
    _presenter.loadAgents();
    setState(() {
      _userLocation = new LatLng(latitude, longitude);
      _cameraPosition = new CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: zoom
      );
    });
  }

  @override
  void onGetCurrentUserLocationError() {
    Fluttertoast.showToast(
        msg: "Gagal memuat, coba lagi.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
  }

}