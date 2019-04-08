import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas Akhir'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: Text('Map')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: Text('Katalog')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.payment),
            title: Text('Order')
          )
        ],
      ),
    );
  }

}