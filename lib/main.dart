import 'package:flutter/material.dart';
import 'package:tugas_akhir/dependency_injection.dart';
import 'package:tugas_akhir/view/login_page.dart';

void main() async {
  Injector.configure(Flavor.PROD);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skripsi',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: LoginPage(),
    );
  }
}