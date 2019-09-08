import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/login_presenter.dart';

class MockView extends Mock implements LoginViewContract {}
class MockRepo extends Mock implements UserRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LoginPresenter presenter;
  final view = MockView();
  final repo = MockRepo();

  setUp(() {
    presenter = LoginPresenter(view);
    presenter.testConstructor(view, repo);
  });

  test('test user login', () async {
    final email = 'someemail@mail.com';
    final password = 'sOmEpAsSwOrD';
    final user = User();
    final throwable = Exception();
    when(repo.loginUser(email, password)).thenAnswer((_) async => Future.value(user));
    await presenter.loginUser(email, password);
    verify(view.showLoading(true, 'Login'));
    verify(repo.loginUser(email, password));
    verify(view.onLoginSuccess(user));
    verify(view.showLoading(false, 'Login')).called(1);
    verifyNever(view.onLoginError());

    clearInteractions(repo);
    clearInteractions(view);

    when(repo.loginUser(email, password)).thenThrow(throwable);
    await presenter.loginUser(email, password);
    verify(view.showLoading(true, 'Login'));
    verify(repo.loginUser(email, password));
    verifyNever(view.onLoginSuccess(user));
    verify(view.onLoginError());
    verify(view.showLoading(false, 'Login')).called(1);
  });

  test('check credential is valid', () {
    final email = 'someemail@mail.com';
    final password = 'sOmEpAsSwOrD';
    final wrongEmail = 'huehue';
    final wrongPassword = 'hm';

    expect(presenter.checkCredentials(email, password), true);
    expect(presenter.checkCredentials(wrongEmail, password), false);
    expect(presenter.checkCredentials(email, wrongPassword), false);
    expect(presenter.checkCredentials(wrongEmail, wrongPassword), false);

    presenter.checkCredentials(wrongEmail, password);
    verify(view.onCredentialInvalid(false, true));
    clearInteractions(view);

    presenter.checkCredentials(email, wrongPassword);
    verify(view.onCredentialInvalid(true, false));
    clearInteractions(view);

    presenter.checkCredentials(wrongEmail, wrongPassword);
    verify(view.onCredentialInvalid(false, false));
  });

  group('validate password', () {
    test('password less than 6 characters', () {
      var result = presenter.validatePassword("abc");
      expect(result, false);
    });
    test('password is 6 characters', () {
      var result = presenter.validatePassword("abcdef");
      expect(result, true);
    });
    test('password more than 6 characters', () {
      var result = presenter.validatePassword("abcdefghijkl");
      expect(result, true);
    });
  });

  group('validate email', () {
    test('email has no .com', () {
      var result = presenter.validateEmail("user@email");
      expect(result, false);
    });
    test('email has no @', () {
      var result = presenter.validateEmail("useremail.com");
      expect(result, false);
    });
    test ('email has no domain name', () {
      var result = presenter.validateEmail("user@.com");
      expect(result, false);
    });
    test('email valid', () {
      var result = presenter.validateEmail("user@email.com");
      expect(result, true);
    });
  });

  test('check is user logged in', () async {
    final user = User();
    when(repo.fetchCurrentUser()).thenAnswer((_) async => Future.value(user));
    await presenter.checkUserLoggedIn();
    verify(repo.fetchCurrentUser());
    verify(view.onUserCheckSuccess(user));
  });
}