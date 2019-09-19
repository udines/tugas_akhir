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

  test('get current location success', () async {
    final location = LatLng();
    when(locRepo.getCurrentLocation()).thenAnswer((_) async => Future.value(location));
    await presenter.getUserCurrentLocation();
    verify(locRepo.getCurrentLocation());
    verify(view.onGetCurrentUserLocationComplete(location.latitude, location.longitude));
  });

  test('get current location fail', () async {
    final error = Exception();
    when(locRepo.getCurrentLocation()).thenThrow(error);
    await presenter.getUserCurrentLocation();
    verify(locRepo.getCurrentLocation());
    verifyNever(view.onGetCurrentUserLocationComplete(any, any));
  });

  test('get address by coordinate success', () async {
    final address = 'Some address';
    when(locRepo.getAddress(1.0, 1.0)).thenAnswer((_) async => Future.value(address));
    await presenter.getAddress(1.0, 1.0);
    verify(locRepo.getAddress(any, any));
    verify(view.onGetAddressComplete(address));
  });

  test('get address by coordinate fail', () async {
    final error = Exception();
    when(locRepo.getAddress(0.0, 0.0)).thenThrow(error);
    await presenter.getAddress(0.0, 0.0);
    verify(locRepo.getAddress(0.0, 0.0));
    verifyNever(view.onGetAddressComplete(any));
  });

  test('post pickup data success', () async {
    final pickup = Pickup();
    when(pickupRepo.postPickup(pickup)).thenAnswer((_) => Future.value());
    await presenter.postPickup(pickup);
    verify(view.showLoading(true));
    verify(pickupRepo.postPickup(pickup));
    verify(view.onPostPickupSuccess(pickup.id));
    verifyNever(view.onTransactionFailed());
    verifyNever(view.showLoading(false));
  });

  test('post pickup data fail', () async {
    final error = Exception();
    final pickup = Pickup();
    when(pickupRepo.postPickup(pickup)).thenThrow(error);
    await presenter.postPickup(pickup);
    verify(view.showLoading(true));
    verify(pickupRepo.postPickup(pickup));
    verifyNever(view.onPostPickupSuccess(pickup.id));
    verify(view.onTransactionFailed());
    verify(view.showLoading(false));
  });

  test('post transactions data success', () async {
    List<Transaction> transactions = [];
    transactions.add(Transaction());
    when(transRepo.postTransactions(transactions)).thenAnswer((_) async => Future.value());
    await presenter.postTransactions(transactions);
    verify(transRepo.postTransactions(transactions));
    verify(view.onPostTransactionsSuccess());
    verify(view.showLoading(false));
    verifyNever(view.onTransactionFailed());
  });

  test('post transactions data fail', () async {
    List<Transaction> transactions = [];
    transactions.add(Transaction());
    final throwable = Exception();
    when(transRepo.postTransactions(transactions)).thenThrow(throwable);
    await presenter.postTransactions(transactions);
    verify(transRepo.postTransactions(transactions));
    verifyNever(view.onPostTransactionsSuccess());
    verify(view.onTransactionFailed());
    verify(view.showLoading(false));
  });
}