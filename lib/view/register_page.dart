import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/register_presenter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> implements RegisterViewContract {
  RegisterPresenter _presenter;
  ProgressDialog _progressDialog;

  _RegisterState() {
    _presenter = RegisterPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    _initDialog(context);
    return null;
  }

  void _initDialog(BuildContext context) {
    _progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage('Registering. Please wait...');
  }

  @override
  void onRegisterFailed() {
    // TODO: implement onRegisterFailed
  }

  @override
  void onRegisterSuccess(User user) {
    _presenter.saveUserInformation(user);
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