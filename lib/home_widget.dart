import 'package:flutter/material.dart';
import 'package:tugas_akhir/home_katalog_widget.dart';
import 'package:tugas_akhir/home_map_widget.dart';
import 'package:tugas_akhir/home_pesanan_widget.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    MapPage(),
    KatalogPage(),
    PesananPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas Akhir'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: Text('Map')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.store),
            title: Text('Katalog')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.swap_horiz),
            title: Text('Pesanan')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}