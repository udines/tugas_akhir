import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/view/home_agent_widget.dart';
import 'package:tugas_akhir/view/home_map_widget.dart';
import 'package:tugas_akhir/view/pickup_transaction_page.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  String _appBarTitle = "Peta Agen Pos";
  final List<Widget> _children = [
    MapPage(),
    AgentPage(),
    PickupTransactionPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     _addData();
      //   },
      // ),
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
        id: "agentC",
        address: "Jl. Kemasan No. 1",
        costPerKM: 2000,
        costPerKG: 1000,
        isReceiveOrder: true,
        name: "Kantorpos Yogyakarta Kotagede",
        phone: "02743994632",
        timeOpen: "09:00",
        timeClose: "15:00",
        latitude: -7.827481,
        longitude: 110.400527,
        userAdmin: User(
          id: "userAgentC",
          name: "Somad",
          address: "Karanglo",
          phone: "08917327493"
        ),
        adminId: "userAgentC",
        city: "Yogyakarta"
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