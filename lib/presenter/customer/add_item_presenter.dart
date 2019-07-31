import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/user/user_data.dart';

abstract class AddItemViewContract {
  void onGetIdSuccess(String id);
  void onGetIdError();
  void onGetCurrentUserSuccess(User user);
  void onGetCurrentUserError();
}

class AddItemPresenter {
  AddItemViewContract _view;

  AddItemPresenter(this._view) {
    
  }

  String createTransactionId() {
    return fs.Firestore.instance.collection('pickups').id;
  }
}