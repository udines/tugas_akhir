import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/customer/home_presenter.dart';

class MockView extends Mock implements HomeViewContract {}
class MockRepo extends Mock implements UserRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final view = MockView();
  final repo = MockRepo();
  HomePresenter presenter;

  setUp(() {
    presenter = HomePresenter(view);
    presenter.testConstructor(view, repo);
  });
  
  test('test user logout success', () async {
    when(repo.logoutUser()).thenAnswer((_) async => Future.value());
    await presenter.logoutUser();
    verify(repo.logoutUser());
    verify(view.onLogoutSuccess());
    verifyNever(view.onLogoutFail());
  });

  test('test user logout fail', () async {
    final error = Exception();
    when(repo.logoutUser()).thenThrow(error);
    await presenter.logoutUser();
    verify(repo.logoutUser());
    verifyNever(view.onLogoutSuccess());
    verify(view.onLogoutFail());
  });
}