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
          location.longitude))
        .catchError((onError) => _view.onGetCurrentUserLocationError(onError.toString()));
  }

  void getAddress(double latitude, double longitude) {
    _locationRepo.getAddress(latitude, longitude)
        .then((address) => _view.onGetAddressComplete(address))
        .catchError((onError) => _view.onGetAddressError(onError.toString()));
  }

  void postPickup(Pickup pickup) {
    var pickupId = fs.Firestore.instance.collection('pickups').id;
    pickup.id = pickupId;
    _pickupRepo.postPickup(pickup)
      .then((onComplete) => _view.onPostPickupSuccess(pickupId));
  }

  void postTransactions(List<Transaction> transactions) {
    _transactionRepo.postTransactions(transactions)
      .then((onComplete) => _view.onPostTransactionsSuccess());
  }
}