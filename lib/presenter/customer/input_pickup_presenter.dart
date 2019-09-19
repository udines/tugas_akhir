import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class InputPickupViewContract {
  void onGetCurrentUserLocationComplete(double latitude, double longitude);
  void onGetAddressComplete(String address);
  void onPostPickupSuccess(String pickupId);
  void onPostTransactionsSuccess();
  void showLoading(bool isLoading);
  void onTransactionFailed();
}

class InputPickupPresenter {
  InputPickupViewContract _view;
  LocationRepository _locationRepo;
  PickupRepository _pickupRepo;
  TransactionRepository _transactionRepo;

  InputPickupPresenter(this._view) {
    _locationRepo = Injector().locationRepository;
    _pickupRepo = Injector().pickupRepository;
    _transactionRepo = Injector().transactionRepository;
  }

  testConstructor(
    InputPickupViewContract view,
    LocationRepository locRepo,
    PickupRepository pickupRepo,
    TransactionRepository transRepo
  ) {
    _view = view;
    _locationRepo = locRepo;
    _pickupRepo = pickupRepo;
    _transactionRepo = transRepo;
  }

  getUserCurrentLocation() async {
    try {
      final location = await _locationRepo.getCurrentLocation();
      _view.onGetCurrentUserLocationComplete(location.latitude, location.longitude);
    } catch(e) {
      print(e.toString());
    }
  }

  getAddress(double latitude, double longitude) async {
    try {
      final address = await _locationRepo.getAddress(latitude, longitude);
      _view.onGetAddressComplete(address);
    } catch(e) {
      print(e.toString());
    }
  }

  postPickup(Pickup pickup) async {
    _view.showLoading(true);
    var pickupId = fs.Firestore.instance.collection('pickups').document().documentID;
    pickup.id = pickupId;
    try {
      await _pickupRepo.postPickup(pickup);
      _view.onPostPickupSuccess(pickupId);
    } catch(e) {
      _view.onTransactionFailed();
      _view.showLoading(false);
    }
  }

  postTransactions(List<Transaction> transactions) async {
    try {
      await _transactionRepo.postTransactions(transactions);
      _view.onPostTransactionsSuccess();
      _view.showLoading(false);
    } catch(e) {
      _view.onTransactionFailed();
      _view.showLoading(false);
    }
  }
}