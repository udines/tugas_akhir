import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/presenter/customer/map_presenter.dart';
import 'package:tugas_akhir/view/customer/agent_detail_page.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> implements MapViewContract {
  MapPresenter _presenter;
  List<Agent> _agents;
  bool _isLoading;
  // LatLng _userLocation;
  CameraPosition _cameraPosition;
  double zoom = 14.4746;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  _MapPageState() {
    _presenter = MapPresenter(this);
  }
  
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          child: _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ) : _mapContainer()
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Pilih agen', style: TextStyle(color: Colors.white),),
            )
          )
        )
      ],
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
  void onLoadAgentComplete(List<Agent> agents) {
    setState(() {
      _isLoading = false;
      _agents = agents;
      _markers.addAll(_createAgentMarker(agents));
    });
  }

  Map<MarkerId, Marker> _createAgentMarker(List<Agent> agents) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    var it = agents.iterator;
    while(it.moveNext()) {
      var id = it.current.id;
      MarkerId markerId = MarkerId(id);
      Marker agentMarker = Marker(
        markerId: markerId,
        position: LatLng(
          it.current.geoPoint.latitude,
          it.current.geoPoint.longitude
        ),
        infoWindow: InfoWindow(
          title: it.current.name,
          snippet: it.current.address,
          onTap: () {
            _onMarkerTapped(markerId);
          }
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
      );
      markers[markerId] = agentMarker;
    }
    return markers;
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
      // _userLocation = new LatLng(latitude, longitude);
      _cameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: zoom
      );
      _markers[markerId] = userMarker;
    });

    _presenter.fetchAgentsNearby(latitude, longitude, 100);
  }

  void _onMarkerTapped(MarkerId markerId) {
    var agent = _agents.firstWhere((agent) => agent.id == markerId.value);
    debugPrint('size: ' + _agents.length.toString());
    if(agent != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AgentDetailPage(
            agent: agent
          )
        )
      );
    }
  }

  @override
  void onLocationPermissionDenied() {
    _presenter.requestLocationPermission();
  }

  @override
  void onLocationPermissionGranted() {
    _presenter.getUserCurrentLocation();
  }

}