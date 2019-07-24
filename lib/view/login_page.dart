import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/login_presenter.dart';
import 'package:tugas_akhir/view/agent/home_page.dart' as agent;
import 'package:tugas_akhir/view/customer/home_page.dart' as customer;
import 'package:tugas_akhir/view/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> implements LoginViewContract {
  TextStyle style = TextStyle(/*fontFamily: 'Montserrat', */fontSize: 14.0);
  LoginPresenter _presenter;
  ProgressDialog _progressDialog;
  String _password = '';
  String _email = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _LoginState() {
    _presenter = LoginPresenter(this);
    _presenter.checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage('Login...');

    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: emailController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: passwordController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButtonAgent = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        onPressed: () {
          _email = emailController.text;
          _password = passwordController.text;
          _presenter.loginUser(_email, _password);
        },
        child: Text("Login Agen",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white)),
      ),
    );
    final loginButtonCustomer = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        onPressed: () {
          _email = emailController.text;
          _password = passwordController.text;
          _presenter.loginUser(_email, _password);
        },
        child: Text("Login Pelanggan",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white)),
      ),
    );

    final registerButton = InkWell(
      child: Text('Register pelanggan'),
      onTap: () {
        _email = emailController.text;
        _password = passwordController.text;
        if (_presenter.checkCredentials(_email, _password)) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
              RegisterPage(
                email: _email,
                password: _password,
              ))
          );
        }
      },
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
                emailField,
                SizedBox(height: 8,),
                passwordField,
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: loginButtonAgent,
                    ),
                    SizedBox(width: 8,),
                    Flexible(
                      flex: 1,
                      child: loginButtonCustomer,
                    )
                  ],
                ),
                SizedBox(height: 40,),
                registerButton
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError() {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Gagal login'))
    );
  }

  @override
  void onLoginSuccess(User user) {
    _presenter.saveUserInformation(user);
    if (user.isAdmin) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => agent.HomePage())
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => customer.HomePage())
      );
    }
  }

  @override
  void onCredentialInvalid(bool isEmailValid, bool isPasswordValid) {
    var message = '';
    if (!isEmailValid && !isPasswordValid) {
      message = 'email dan password tidak valid';
    } else if (!isEmailValid) {
      message = 'email tidak valid';
    } else if (!isPasswordValid) {
      message = 'password tidak valid';
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0
    );
  }

  @override
  void showLoading(bool isShowing) {
    if (isShowing) {
      _progressDialog.show();
    } else {
      _progressDialog.hide();
    }
  }

  @override
  void onUserCheckSuccess(User user) {
    if (user.isAdmin) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => agent.HomePage())
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => customer.HomePage())
      );
    }
  }
}