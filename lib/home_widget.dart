import 'package:flutter/material.dart';
import 'package:tugas_akhir/view/agent_page/home_agent_widget.dart';
import 'package:tugas_akhir/view/conversation_page/home_conversation_page.dart';
import 'package:tugas_akhir/view/map_page/home_map_widget.dart';
import 'package:tugas_akhir/view/pickup_transaction_page/pickup_transaction_page.dart';

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