import 'package:tugas_akhir/data/item_data.dart';
import 'package:tugas_akhir/data/transaction_data.dart';
import 'package:tugas_akhir/data/user_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AddItemViewContract {
  void onGetIdSuccess(String id);
  void onGetIdError();
  void onGetTransactionIdSuccess(String id);
  void onGetTransactionIdError();
  void onGetCurrentUserSuccess(User user);
  void onGetCurrentUserError();
}

class AddItemPresenter {
  AddItemViewContract _view;
  ItemRepository _repo;
  TransactionRepository _transRepo;
  UserRepository _userRepo;

  AddItemPresenter(this._view) {
    _repo = Injector().itemRepository;
    _transRepo = Injector().transactionRepository;
    _userRepo = Injector().userRepository;
  }

  void createItemId() {
    _repo.createId()
        .then((id) => _view.onGetIdSuccess(id))
        .catchError((onError) => _view.onGetIdError());
  }

  void createTransactionId() {
    _transRepo.createId()
        .then((id) => _view.onGetTransactionIdSuccess(id))
        .catchError((onError) => _view.onGetTransactionIdError());
  }

  void getCurrentUser() {
    _userRepo.fetchCurrentUser()
        .then((user) => _view.onGetCurrentUserSuccess(user))
        .catchError((onError) => _view.onGetCurrentUserError());
  }
}