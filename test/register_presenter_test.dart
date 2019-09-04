import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/register_presenter.dart';

class MockUserRepo extends Mock implements UserRepository {}
class MockLocRepo extends Mock implements LocationRepository {}
class MockView extends Mock implements RegisterViewContract {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final userRepo = MockUserRepo();
  final locRepo = MockLocRepo();
  final view = MockView();
  RegisterPresenter presenter;

  setUp(() {
    presenter = RegisterPresenter(view);
    presenter.testConstructor(view, userRepo, locRepo);
  });

  test('register user', () async {
    final user = User();
    final throwable = Exception();
    final email = 'anemail@mail.com';
    final password = 'aPassword123';
    final wrongEmail = 'hehe';
    final wrongPassword = '123';
    when(userRepo.registerUser(email, password, user)).thenAnswer((_) => Future.value());
    await presenter.registerUser(email, password, user);
    verify(view.showLoading(true));
    verify(userRepo.registerUser(email, password, user));
    verify(view.showLoading(false)).called(1);
    verify(view.onRegisterSuccess(user));
    verifyNever(view.onRegisterFailed());
    verifyNever(view.onCredentialsInvalid());

    clearInteractions(view);
    clearInteractions(userRepo);

    when(userRepo.registerUser(email, password, user)).thenThrow(throwable);
    await presenter.registerUser(email, password, user);
    verify(view.showLoading(true));
    verify(userRepo.registerUser(email, password, user));
    verifyNever(view.onRegisterSuccess(any));
    verify(view.showLoading(false)).called(1);
    verify(view.onRegisterFailed());
    verifyNever(view.onCredentialsInvalid());

    clearInteractions(view);
    clearInteractions(userRepo);

    await presenter.registerUser(wrongEmail, wrongPassword, user);
    verifyNever(view.showLoading(true));
    verifyNever(userRepo.registerUser(wrongEmail, wrongPassword, user));
    verifyNever(view.onRegisterSuccess(any));
    verifyNever(view.showLoading(false));
    verifyNever(view.onRegisterFailed());
    verify(view.onCredentialsInvalid());
  });
}