import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/view/customer/input_pickup_page.dart';
import 'package:tugas_akhir/presenter/customer/agent_detail_presenter.dart';

class AgentDetailPage extends StatefulWidget {
  final Agent agent;

  AgentDetailPage({Key key, @required this.agent}) : super(key: key);

  @override
  _AgentDetailPageState createState() => _AgentDetailPageState();
}

class _AgentDetailPageState extends State<AgentDetailPage> implements AgentDetailViewContract {
  BuildContext context;
  AgentDetailPresenter _presenter;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  User _currentUser;

  _AgentDetailPageState() {
    _presenter = AgentDetailPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.getCurrentUser();
    _markers[MarkerId(widget.agent.id)] = Marker(
      markerId: MarkerId(widget.agent.id),
      position: LatLng(
        widget.agent.geoPoint.latitude,
        widget.agent.geoPoint.longitude
      ),
      infoWindow: InfoWindow(
        title: widget.agent.name,
        onTap: () {}
      ),
      icon: BitmapDescriptor.defaultMarker
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agent.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //nama agen
              Text("Nama agen", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              Text(widget.agent.name, style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 16,),
              //alamat dan jam buka/tutup
              Text("Alamat", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              Text(widget.agent.address, style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 16,),
              Text("Lokasi agen", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          widget.agent.geoPoint.latitude,
                          widget.agent.geoPoint.longitude),
                      zoom: 14.4746
                  ),
                  markers: Set<Marker>.of(_markers.values),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                )
                ,
              ),
              SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Jam buka", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(widget.agent.timeOpen, style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 32),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Jam tutup", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      Text(widget.agent.timeClose, style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                  SizedBox(width: 32,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Menerima penjemputan", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      _receiveOrder(widget.agent.isReceiveOrder),
                    ],
                  )
                ],
              ),
              //peta kecil dengan rute dari lokasi pengguna ke lokasi agen

              Padding(padding: EdgeInsets.only(top: 16),),
              //no telepon dan button telepon & chat
              Text("Nomor telepon", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              Text(widget.agent.phone, style: TextStyle(fontSize: 16, color: Colors.black)),
              ButtonTheme.bar(
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      child: Text("Telepon"),
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 16),),
              SizedBox(
                width: double.infinity,
                child: ButtonTheme.bar(
                  child: RaisedButton(
                    onPressed: () {
                      _goToOrderInputPage(widget.agent);
                    },
                    child: Text("PESAN PENJEMPUTAN", style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void _goToOrderInputPage(Agent agent) {
    if(agent != null && _currentUser != null) {
      if(_presenter.isAgentOpen(agent, DateTime.now())) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InputPickupPage(
              agent: agent,
              user: _currentUser,
            )
          )
        );
      } else {
        //Agen sedang tutup
        Fluttertoast.showToast(
          msg: 'Agen tutup',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0
        );
      }
    } else {
      //data agen atau pengguna tidak ada
      Fluttertoast.showToast(
        msg: 'Tidak ditemukan data agen atau data pengguna',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0
      );
    }
  }

  Widget _receiveOrder(bool isReceiveOrder) {
    var text = "";
    if(isReceiveOrder) {
      text = "YA";
    } else {
      text = "TIDAK";
    }
    return Text(text, style: TextStyle(
      fontSize: 16, 
      color: Colors.black, 
      fontWeight: FontWeight.w800
      )
    );
  }

  @override
  void onGetCurrentUserComplete(User user) {
    setState(() {
      _currentUser = user;
    });
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
}