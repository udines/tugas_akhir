import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class AddItemViewContract {
  void onGetSenderAddressSuccess(String address);
  void onGetSenderProvinceSuccess(String province);
}

class AddItemPresenter {
  AddItemViewContract _view;
  LocationRepository _locationRepo;

  AddItemPresenter(this._view) {
    _locationRepo = Injector().locationRepository;
  }

  String createTransactionId() {
    return fs.Firestore.instance.collection('pickups').id;
  }

  void getSenderAddress() {
    
  }

  void getSenderProvince() {

  }
}