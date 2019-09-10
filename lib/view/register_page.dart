import 'package:flutter/material.dart';
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
  RegisterPresenter _presenter;
  ProgressDialog _progressDialog;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  _RegisterState() {
    _presenter = RegisterPresenter(this);
    _presenter.getInitialLocationInfo();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage('Registrasi');

    TextField nameField = TextField(
      obscureText: false,
      controller: nameController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'Masukkan nama',
        labelText: 'Nama'
      ),
    );

    TextField addressField = TextField(
      obscureText: false,
      controller: addressController,
      textCapitalization: TextCapitalization.words,
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        hintText: 'Masukkan alamat',
        labelText: 'Alamat'
      )
    );

    TextField cityField = TextField(
      obscureText: false,
      controller: cityController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Kota',
        hintText: 'Masukkan kota',
      ),
    );

    TextField postalCodeField = TextField(
      obscureText: false,
      keyboardType: TextInputType.number,
      controller: postalCodeController,
      decoration: InputDecoration(
        hintText: 'Masukkan kode pos',
        labelText: 'Kode Pos'
      )
    );

    TextField phoneField = TextField(
      obscureText: false,
      controller: phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Masukkan nomor telepon',
        labelText: 'Telepon',
      )
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        onPressed: () {
          if (nameController.text.length > 0 && addressController.text.length > 0 &&
            phoneController.text.length > 0) {
            User newUser = User(
              name: nameController.text,
              address: addressController.text,
              phone: phoneController.text,
              city: cityController.text,
              postalCode: postalCodeController.text,
              email: widget.email
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
          style: TextStyle(color: Colors.white)
        )
      ),
    );
    
    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                nameField,
                SizedBox(height: 8,),
                addressField,
                SizedBox(height: 8,),
                cityField,
                SizedBox(height: 8,),
                postalCodeField,
                SizedBox(height: 8,),
                phoneField,
                SizedBox(height: 20,),
                registerButton
              ],
            ),
          ),
        ),
      )
    );
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage())
    );
  }

  @override
  void showLoading(bool isLoading) {
    if (isLoading) {
      setState(() {
        _progressDialog.show();
      });
    } else {
      setState(() {
        _progressDialog.hide();
      });
    }
  }

  @override
  void onGetAddressSuccess(String address) {
    setState(() {
      addressController.text = address;
    });
  }

  @override
  void onGetCitySuccess(String city) {
    setState(() {
      cityController.text = city;
    });
  }

  @override
  void onGetPostalCodeSuccess(String postalCode) {
    setState(() {
      postalCodeController.text = postalCode;
    });
  }

  @override
  void onPermissionDenied() {
    
  }

  @override
  void onCredentialsInvalid() {
    print('credentials invalid');
  }
}