import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/data/user/user_data_mock.dart';
import 'package:tugas_akhir/data/user/user_data_prod.dart';

class UserMock extends MockUserRepository {}
class UserProd extends ProdUserRepository {}

main () {
  group('mock testing', () {
    var mock = UserMock();
    test('mock fetch current user', () async {
      var result = await mock.fetchCurrentUser();
      expect(result, isInstanceOf<User>());
    });
    test('prod fetch user by id', () async {
      var result = await mock.fetchUser("userId");
      expect(result, isInstanceOf<User>());
    });
    test('login user', () async {
      var result = await mock.loginUser("user@email.com", "password");
      expect(result, isInstanceOf<User>());
    });
  });

  group('production testing', () {
    var prod = UserProd();
    test('prod fetch current user', () async {
      var result = await prod.fetchCurrentUser();
      expect(result, isInstanceOf<User>());
    });
    test('prod fetch user by available id', () async {
      var result = await prod.fetchUser("userIdAvailable");
      expect(result, isInstanceOf<User>());
    });
    test('prod fetch user by unavailable id', () async {
      var result = await prod.fetchUser("userIdUnavailable");
      expect(result, throwsException);
    });
    test('prod login user success', () async {
      var result = await prod.loginUser("user@mail.com", "password");
      expect(result, throwsException);
    });
    test('prod login user fail', () async {
      var result = await prod.loginUser("fake email", "fake password");
      expect(result, throwsException);
    });
  });
}