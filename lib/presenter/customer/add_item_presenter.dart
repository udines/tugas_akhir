import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/item/item_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AddItemViewContract {
  void onGetIdSuccess(String id);
  void onGetIdError();
  void onGetCurrentUserSuccess(User user);
  void onGetCurrentUserError();
}

class AddItemPresenter {
  AddItemViewContract _view;
  ItemRepository _itemRepo;
  TransactionRepository _transRepo;
  UserRepository _userRepo;

  AddItemPresenter(this._view) {
    _itemRepo = Injector().itemRepository;
    _transRepo = Injector().transactionRepository;
    _userRepo = Injector().userRepository;
  }

  String createItemId() {
    return fs.Firestore.instance.collection('pickups').document()
    .collection('transactions').document().collection('item')
    .document().documentID;
  }

  String createTransactionId() {
    return fs.Firestore.instance.collection('pickups').document()
    .collection('transactions').document().documentID;
  }

  void getCurrentUser() {
    _userRepo.fetchCurrentUser()
        .then((user) => _view.onGetCurrentUserSuccess(user))
        .catchError((onError) => _view.onGetCurrentUserError());
  }

  void postItem(Item item, String transactionId) {
    _itemRepo.postItem(item, transactionId);
  }
}