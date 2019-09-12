import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/customer/pickup_list_presenter.dart';

class MockView extends Mock implements PickupViewContract {}
class MockPickRepo extends Mock implements PickupRepository {}
class MockUserRepo extends Mock implements UserRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final view = MockView();
  final pickRepo = MockPickRepo();
  final userRepo = MockUserRepo();
  PickupPresenter presenter;

  setUp(() {
    presenter = PickupPresenter(view);
    presenter.testConstructor(view, pickRepo, userRepo);
  });

  test('load pickup by user success', () async {
    final userId = 'userId';
    List<Pickup> pickups = [];
    pickups.add(Pickup());
    when(userRepo.getUserId()).thenAnswer((_) async => Future.value(userId));
    when(pickRepo.fetchPickupsByUser(userId)).thenAnswer((_) async => Future.value(pickups));
    await presenter.loadPickupsByUser();
    verify(userRepo.getUserId());
    verify(pickRepo.fetchPickupsByUser(userId));
    verify(view.onLoadPickupTransactionComplete(pickups));
    verifyNever(view.onLoadPickupTransactionError());
  });

  test('load pickup by user erro get user id', () async {
    final userId = 'userId';
    final throwable = Exception();
    List<Pickup> pickups = [];
    pickups.add(Pickup());
    when(userRepo.getUserId()).thenThrow(throwable);
    when(pickRepo.fetchPickupsByUser(userId)).thenAnswer((_) async => Future.value(pickups));
    await presenter.loadPickupsByUser();
    verify(userRepo.getUserId());
    verifyNever(pickRepo.fetchPickupsByUser(userId));
    verifyNever(view.onLoadPickupTransactionComplete(pickups));
    verify(view.onLoadPickupTransactionError());
  });

  test('load pickup by user error', () async {
    final userId = 'userId';
    final throwable = Exception();
    List<Pickup> pickups = [];
    pickups.add(Pickup());
    when(userRepo.getUserId()).thenAnswer((_) async => Future.value(userId));
    when(pickRepo.fetchPickupsByUser(userId)).thenThrow(throwable);
    await presenter.loadPickupsByUser();
    verify(userRepo.getUserId());
    verify(pickRepo.fetchPickupsByUser(userId));
    verifyNever(view.onLoadPickupTransactionComplete(pickups));
    verify(view.onLoadPickupTransactionError());
  });

  test('load pickup by user error all', () async {
    final userId = 'userId';
    final throwable = Exception();
    List<Pickup> pickups = [];
    pickups.add(Pickup());
    when(userRepo.getUserId()).thenThrow(throwable);
    when(pickRepo.fetchPickupsByUser(userId)).thenThrow(throwable);
    await presenter.loadPickupsByUser();
    verify(userRepo.getUserId());
    verifyNever(pickRepo.fetchPickupsByUser(userId));
    verifyNever(view.onLoadPickupTransactionComplete(pickups));
    verify(view.onLoadPickupTransactionError());
  });
}