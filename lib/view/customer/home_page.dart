import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/view/customer/agent_list_page.dart';
import 'package:tugas_akhir/view/customer/map_page.dart';
import 'package:tugas_akhir/view/customer/pickup_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _appBarTitle = "Peta Agen Pos";
  final List<Widget> _children = [
    MapPage(),
    AgentListPage(),
    PickupListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
     /*floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
       onPressed: () {
         _addData();
       },
     ),*/
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: Text('Peta')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.store),
            title: Text('Agen')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.swap_horiz),
            title: Text('Transaksi')
          )
        ],
      ),
    );
  }

  void _addData() {
    Agent data;

    data = Agent(
        id: "agentB",
        address: "Jl. Sorogenen No. 1",
        costPerKM: 1000,
        costPerKG: 2000,
        isReceiveOrder: false,
        name: "Post Office Sorogenen",
        phone: "02749171179",
        timeOpen: "07:00",
        timeClose: "21:00",
        geoPoint: GeoPoint(-7.828114, 110.406007),
        userAdmin: new User(
            id: "userAgentB",
            name: "Hamid",
            address: "Sorogenen",
            phone: "089619237368"
        )
    );

    Firestore.instance.collection('agents').add(data.toMap());
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0:
          _appBarTitle = "Peta Agen Pos";
          break;
        case 1:
          _appBarTitle = "Katalog Agen Pos";
          break;
        case 3:
          _appBarTitle = "Daftar Transaksi";
          break;
        default:
          _appBarTitle= "Agen Pos Indonesia";
          break;
      }
    });
  }
}