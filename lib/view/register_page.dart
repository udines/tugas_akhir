import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/register_presenter.dart';

import 'customer/home_page.dart';

class RegisterPage extends StatefulWidget {
  final String email;
  final String password;

  RegisterPage({Key key, @required this.email, @required this.password})
    : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> implements RegisterViewContract {
  TextStyle style = TextStyle(/*fontFamily: 'Montserrat', */fontSize: 14.0);
  RegisterPresenter _presenter;
  ProgressDialog _progressDialog;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  _RegisterState() {
    _presenter = RegisterPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    _initDialog(context);

    final nameField = TextField(
      obscureText: false,
      style: style,
      controller: nameController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Nama",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final addressField = TextField(
      obscureText: false,
      style: style,
      controller: addressController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Alamat",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final phoneField = TextField(
      obscureText: false,
      style: style,
      controller: phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Telepon",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        onPressed: () {
          if (nameController.text.length > 0 && addressController.text.length > 0 &&
            phoneController.text.length > 0) {
            User newUser = User(
              name: nameController.text,
              address: addressController.text,
              phone: phoneController.text
            );
            _presenter.registerUser(widget.email, widget.password, newUser);
          } else {
            Fluttertoast.showToast(
              msg: "Lengkapi data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              fontSize: 16.0
            );
          }
        },
        child: Text("Registrasi",
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
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                nameField,
                SizedBox(height: 8,),
                addressField,
                SizedBox(height: 8,),
                phoneField,
                SizedBox(height: 20,),
                registerButton
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _initDialog(BuildContext context) {
    _progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage('Registrasi...');
  }

  @override
  void onRegisterFailed() {
    Fluttertoast.showToast(
      msg: "Registrasi gagal",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      fontSize: 16.0
    );
  }

  @override
  void onRegisterSuccess(User user) {
    _presenter.saveUserInformation(user);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage())
    );
  }

  @override
  void showLoading(bool isLoading) {
    if (isLoading) {
      _progressDialog.show();
    } else {
      _progressDialog.hide();
    }
  }
}