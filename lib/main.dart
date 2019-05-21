import 'package:flutter/material.dart';
import 'package:tugas_akhir/dependency_injection.dart';
import 'package:tugas_akhir/view/login_page.dart';

void main() async {
  Injector.configure(Flavor.MOCK);
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Akhir',
      home: LoginPage(),
    );
  }
}