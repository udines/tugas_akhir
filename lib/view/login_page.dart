import 'package:flutter/material.dart';
import 'package:tugas_akhir/view/agent/home_page.dart' as agent;
import 'package:tugas_akhir/view/customer/home_page.dart' as customer;


class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButonAgent = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => agent.HomePage()
            )
          );
        },
        child: Text("Login Agen",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white)),
      ),
    );
    final loginButonCustomer = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => customer.HomePage()
            )
          );
        },
        child: Text("Login Pelanggan",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                emailField,
                SizedBox(height: 8,),
                passwordField,
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: loginButonAgent,
                    ),
                    SizedBox(width: 8,),
                    Flexible(
                      flex: 1,
                      child: loginButonCustomer,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}