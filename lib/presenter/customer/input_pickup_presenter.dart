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

  void getUserCurrentLocation() {
    _locationRepo.getCurrentLocation()
        .then((location) => _view.onGetCurrentUserLocationComplete(
          location.latitude, 
          location.longitude)
        );
  }

  void getAddress(double latitude, double longitude) {
    _locationRepo.getAddress(latitude, longitude)
        .then((address) => _view.onGetAddressComplete(address));
  }

  void postPickup(Pickup pickup) {
    _view.showLoading(true);
    var pickupId = fs.Firestore.instance.collection('pickups').document().documentID;
    pickup.id = pickupId;
    _pickupRepo.postPickup(pickup)
      .then((onComplete) => _view.onPostPickupSuccess(pickupId))
      .catchError((onError) {
        _view.onTransactionFailed();
        _view.showLoading(false);
      });
  }

  void postTransactions(List<Transaction> transactions) {
    _transactionRepo.postTransactions(transactions)
      .then((onComplete) {
        _view.onPostTransactionsSuccess();
        _view.showLoading(false);
      })
      .catchError((onError) {
        _view.onTransactionFailed();
        _view.showLoading(false);
      });
  }
}