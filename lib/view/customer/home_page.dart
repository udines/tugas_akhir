import 'package:flutter/material.dart';
import 'package:tugas_akhir/presenter/customer/home_presenter.dart';
import 'package:tugas_akhir/view/customer/agent_list_page.dart';
import 'package:tugas_akhir/view/customer/map_page.dart';
import 'package:tugas_akhir/view/customer/pickup_list_page.dart';
import 'package:tugas_akhir/view/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> implements HomeViewContract {
  int _currentIndex = 0;
  String _appBarTitle = "Peta Agen Pos";
  HomePresenter _presenter;

  _HomePageState() {
    _presenter = HomePresenter(this);
  }

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
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _presenter.logoutUser();
            },
          ),
        ],
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
          _appBarTitle = "Peta Agen Terdekat";
          break;
        case 1:
          _appBarTitle = "Katalog Agen Terdekat";
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

  @override
  void onLogoutSuccess() {
    _presenter.clearPreferences();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => LoginPage())
    );
  }
}