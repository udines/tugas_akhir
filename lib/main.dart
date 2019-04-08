import 'package:flutter/material.dart';
import 'package:tugas_akhir/home_widget.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My own App',
      home: Home(),
    );
  }

}