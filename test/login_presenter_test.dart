import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/presenter/login_presenter.dart';

class LoginMock extends Mock {
  static LoginViewContract view;
  LoginPresenter presenter = LoginPresenter(view);
}

main() {
  group('validate password', () {
    final LoginMock loginMock = LoginMock();

    test('password less than 6 characters', () {
      var result = loginMock.presenter.validatePassword("abc");
      expect(result, false);
    });

    test('password is 6 characters', () {
      var result = loginMock.presenter.validatePassword("abcdef");
      expect(result, true);
    });

    test('password more than 6 characters', () {
      var result = loginMock.presenter.validatePassword("abcdefghijkl");
      expect(result, true);
    });
  });

  group('validate email', () {
    final LoginMock loginMock = LoginMock();

    test('email has no .com', () {
      var result = loginMock.presenter.validateEmail("user@email");
      expect(result, false);
    });

    test('email has no @', () {
      var result = loginMock.presenter.validateEmail("useremail.com");
      expect(result, false);
    });

    test ('email has no domain name', () {
      var result = loginMock.presenter.validateEmail("user@.com");
      expect(result, false);
    });

    test('email valid', () {
      var result = loginMock.presenter.validateEmail("user@email.com");
      expect(result, true);
    });
  });
}