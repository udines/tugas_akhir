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

  _MapPageState() {
    _presenter = MapPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
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