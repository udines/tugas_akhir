import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/presenter/customer/input_item_presenter.dart';

class MockView extends Mock implements InputItemViewContract {}
class MockLocationRepo extends Mock implements LocationRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final view = MockView();
  final locRepo = MockLocationRepo();
  InputItemPresenter presenter;

  setUp(() {
    presenter = InputItemPresenter(view);
    presenter.testConstructor(view, locRepo);
  });

  test('create transaction id return unique string', () {
    var result = true;
    var id1 = presenter.createTransactionId();
    var id2 = presenter.createTransactionId();
    for (int i = 0; i < 1000; i++) {
      if (id1 != id2) {
        result = result && true;
      } else {
        result = result && false;
        break;
      }
      id1 = id2;
      id2 = presenter.createTransactionId();
    }
    expect(result, true);
  });

  test('get sender address', () async {
    final address = 'Some address';
    final error = Exception();
    when(locRepo.getCurrentAddress()).thenAnswer((_) async => Future.value(address));
    await presenter.getSenderAddress();
    expect(await locRepo.getCurrentAddress(), isInstanceOf<String>());
    verify(locRepo.getCurrentAddress());
    verify(view.onGetSenderAddressSuccess(address));

    clearInteractions(locRepo);
    clearInteractions(view);

    when(locRepo.getCurrentAddress()).thenThrow(error);
    await presenter.getSenderAddress();
    verify(locRepo.getCurrentAddress());
    verifyNever(view.onGetSenderAddressSuccess(address));
  });

  test('get sender province', () async {
    final province = 'Province';
    final error = Exception();
    when(locRepo.getProvince()).thenAnswer((_) async => Future.value(province));
    await presenter.getSenderProvince();
    expect(await locRepo.getProvince(), isInstanceOf<String>());
    verify(locRepo.getProvince());
    verify(view.onGetSenderProvinceSuccess(province));

    clearInteractions(locRepo);
    clearInteractions(view);

    when(locRepo.getProvince()).thenThrow(error);
    await presenter.getSenderProvince();
    verify(locRepo.getProvince());
    verifyNever(view.onGetSenderProvinceSuccess(province));
  });
}