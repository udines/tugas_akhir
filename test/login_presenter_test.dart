import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/presenter/login_presenter.dart';

class LoginMock extends Mock {
  static LoginViewContract view;
  LoginPresenter presenter = LoginPresenter(view);
}

void main() {

  test('password less than 6 characters', () {
    var result = LoginMock().presenter.validatePassword("abc");
    expect(result, false);
  });

  test('password is 6 characters', () {
    var result = LoginMock().presenter.validatePassword("abcdef");
    expect(result, true);
  });

  test('password more than 6 characters', () {
    var result = LoginMock().presenter.validatePassword("abcdefghijkl");
    expect(result, true);
  });

  test('email has no .com', () {
    var result = LoginMock().presenter.validateEmail("user@email");
    expect(result, false);
  });

  test('email has no @', () {
    var result = LoginMock().presenter.validateEmail("useremail.com");
    expect(result, false);
  });

  test ('email has no domain name', () {
    var result = LoginMock().presenter.validateEmail("user@.com");
    expect(result, false);
  });

  test('email valid', () {
    var result = LoginMock().presenter.validateEmail("user@email.com");
    expect(result, true);
  });
}