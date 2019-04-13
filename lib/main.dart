import 'package:flutter/material.dart';
import 'package:tugas_akhir/home_widget.dart';
import 'package:tugas_akhir/dependency_injection.dart';

void main() async {
  Injector.configure(Flavor.MOCK);
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Akhir',
      home: Home(),
    );
  }
}