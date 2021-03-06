import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/agent/home_presenter.dart';

class MockView extends Mock implements HomeViewContract {}
class MockPickupRepo extends Mock implements PickupRepository {}
class MockUserRepo extends Mock implements UserRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final view = MockView();
  final pickupRepo = MockPickupRepo();
  final userRepo = MockUserRepo();
  HomePresenter presenter;

  setUp(() {
    presenter = HomePresenter(view);
    presenter.testConstructor(view, pickupRepo, userRepo);
  });

  test('logout user success', () async {
    when(userRepo.logoutUser()).thenAnswer((_) async => Future.value());
    await presenter.logoutUser();
    verify(userRepo.logoutUser());
    verify(view.onLogoutSuccess());
  });

  test('logout user fail', () async {
    when(userRepo.logoutUser()).thenThrow(Exception());
    await presenter.logoutUser();
    verify(userRepo.logoutUser());
    verifyNever(view.onLogoutSuccess());
  });

  test('load pickup data success', () async {
    final agentId = 'agentId';
    List<Pickup> pickups = [];
    pickups.add(Pickup());
    when(pickupRepo.fetchPickupsByAgent(agentId)).thenAnswer((_) async => Future.value(pickups));
    await presenter.loadPickupTransactions(agentId);
    verify(pickupRepo.fetchPickupsByAgent(agentId));
    verify(view.onLoadPickupTransactionComplete(pickups));
    verifyNever(view.onLoadPickupTransactionError());
  });

  test('load pickup data fail', () async {
    final agentId = 'agentId';
    List<Pickup> pickups = [];
    pickups.add(Pickup());
    when(pickupRepo.fetchPickupsByAgent(agentId)).thenThrow(Exception());
    await presenter.loadPickupTransactions(agentId);
    verify(pickupRepo.fetchPickupsByAgent(agentId));
    verifyNever(view.onLoadPickupTransactionComplete(pickups));
    verify(view.onLoadPickupTransactionError());
  });

  test('get current user success', () async {
    final user = User();
    when(userRepo.fetchCurrentUser()).thenAnswer((_) async => Future.value(user));
    await presenter.getCurrentUser();
    verify(userRepo.fetchCurrentUser());
    verify(view.onGetCurrentUserComplete(user));
  });

  test('get current user fail', () async {
    final user = User();
    final throwable = Exception();
    when(userRepo.fetchCurrentUser()).thenThrow(throwable);
    await presenter.getCurrentUser();
    verify(userRepo.fetchCurrentUser());
    verifyNever(view.onGetCurrentUserComplete(user));
  });

  test('update pickup status success', () async {
    final status = 'new status';
    final pickupId = 'pickupId';
    when(pickupRepo.updateStatus(status, pickupId)).thenAnswer((_) async => Future.value());
    await presenter.updateStatus(status, pickupId);
    verify(pickupRepo.updateStatus(status, pickupId));
    verify(view.onUpdateStatusSuccess());
  });

  test('update pickup status fail', () async {
    final status = 'new status';
    final pickupId = 'pickupId';
    when(pickupRepo.updateStatus(status, pickupId)).thenThrow(Exception());
    await presenter.updateStatus(status, pickupId);
    verify(pickupRepo.updateStatus(status, pickupId));
    verifyNever(view.onUpdateStatusSuccess());
  });
}