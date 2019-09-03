import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/dependency_injection.dart';

abstract class InputItemViewContract {
  void onGetSenderAddressSuccess(String address);
  void onGetSenderProvinceSuccess(String province);
}

class InputItemPresenter {
  InputItemViewContract _view;
  LocationRepository _locationRepo;

  InputItemPresenter(this._view) {
    _locationRepo = Injector().locationRepository;
  }

  String createTransactionId() {
    return fs.Firestore.instance.collection('transactions').document().documentID;
  }

  void getSenderAddress() {
    _locationRepo.getCurrentAddress()
      .then((address) => _view.onGetSenderAddressSuccess(address));
  }

  void getSenderProvince() {
    _locationRepo.getProvince()
      .then((province) => _view.onGetSenderProvinceSuccess(province));
  }
}