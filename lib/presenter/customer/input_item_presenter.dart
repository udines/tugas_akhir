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

  testConstructor(InputItemViewContract view, LocationRepository locRepo) {
    _view = view;
    _locationRepo = locRepo;
  }

  String createTransactionId() {
    return fs.Firestore.instance.collection('transactions').document().documentID;
  }

  getSenderAddress() async {
    try {
      final address = await _locationRepo.getCurrentAddress();
      _view.onGetSenderAddressSuccess(address);
    } catch(e) {

    }
  }

  getSenderProvince() async {
    try {
      final province = await _locationRepo.getProvince();
      _view.onGetSenderProvinceSuccess(province);
    } catch(e) {

    }
  }
}