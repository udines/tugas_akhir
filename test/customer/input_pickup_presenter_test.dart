import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/presenter/customer/input_pickup_presenter.dart';

class MockView extends Mock implements InputPickupViewContract {}
class MockLocRepo extends Mock implements LocationRepository {}
class MockPickupRepo extends Mock implements PickupRepository {}
class MockTransRepo extends Mock implements TransactionRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final view = MockView();
  final locRepo = MockLocRepo();
  final pickupRepo = MockPickupRepo();
  final transRepo = MockTransRepo();
  InputPickupPresenter presenter;

  setUp(() {
    presenter = InputPickupPresenter(view);
    presenter.testConstructor(view, locRepo, pickupRepo, transRepo);
  });

  test('get current location', () async {
    final location = LatLng();
    final error = Exception();
    when(locRepo.getCurrentLocation()).thenAnswer((_) async => Future.value(location));
    await presenter.getUserCurrentLocation();
    verify(locRepo.getCurrentLocation());
    verify(view.onGetCurrentUserLocationComplete(location.latitude, location.longitude));

    clearInteractions(locRepo);
    clearInteractions(view);

    when(locRepo.getCurrentLocation()).thenThrow(error);
    await presenter.getUserCurrentLocation();
    verify(locRepo.getCurrentLocation());
    verifyNever(view.onGetCurrentUserLocationComplete(any, any));
  });

  test('get address by coordinate', () async {
    final address = 'Some address';
    final error = Exception();
    when(locRepo.getAddress(1.0, 1.0)).thenAnswer((_) async => Future.value(address));
    await presenter.getAddress(1.0, 1.0);
    verify(locRepo.getAddress(any, any));
    verify(view.onGetAddressComplete(address));

    clearInteractions(locRepo);
    clearInteractions(view);

    when(locRepo.getAddress(0.0, 0.0)).thenThrow(error);
    await presenter.getAddress(0.0, 0.0);
    verify(locRepo.getAddress(0.0, 0.0));
    verifyNever(view.onGetAddressComplete(any));
  });

  test('post pickup data', () async {
    final error = Exception();
    final pickup = Pickup();
    when(pickupRepo.postPickup(pickup)).thenAnswer((_) => Future.value());
    await presenter.postPickup(pickup);
    verify(view.showLoading(true));
    verify(pickupRepo.postPickup(pickup));
    verify(view.onPostPickupSuccess(pickup.id));
    verifyNever(view.onTransactionFailed());
    verifyNever(view.showLoading(false));

    clearInteractions(pickupRepo);
    clearInteractions(view);

    when(pickupRepo.postPickup(pickup)).thenThrow(error);
    await presenter.postPickup(pickup);
    verify(view.showLoading(true));
    verify(pickupRepo.postPickup(pickup));
    verifyNever(view.onPostPickupSuccess(pickup.id));
    verify(view.onTransactionFailed());
    verify(view.showLoading(false));
  });

  test('post transactions data', () async {
    List<Transaction> transactions = [];
    transactions.add(Transaction());
    final throwable = Exception();
    when(transRepo.postTransactions(transactions)).thenAnswer((_) async => Future.value());
    await presenter.postTransactions(transactions);
    verify(transRepo.postTransactions(transactions));
    verify(view.onPostTransactionsSuccess());
    verify(view.showLoading(false));
    verifyNever(view.onTransactionFailed());

    clearInteractions(view);
    clearInteractions(transRepo);

    when(transRepo.postTransactions(transactions)).thenThrow(throwable);
    await presenter.postTransactions(transactions);
    verify(transRepo.postTransactions(transactions));
    verifyNever(view.onPostTransactionsSuccess());
    verify(view.onTransactionFailed());
    verify(view.showLoading(false));
  });
}