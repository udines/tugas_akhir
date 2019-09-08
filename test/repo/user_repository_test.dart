import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/data/user/user_data_mock.dart';
import 'package:tugas_akhir/data/user/user_data_prod.dart';

class UserMock extends MockUserRepository {}
class UserProd extends ProdUserRepository {}

main () {
  group('mock user testing', () {
    var mock = UserMock();
    test('mock fetch current user', () async {
      var result = await mock.fetchCurrentUser();
      expect(result, isInstanceOf<User>());
    });
    test('mock login user', () async {
      var result = await mock.loginUser("user@email.com", "password");
      expect(result, isInstanceOf<User>());
    });
    test('get single user', () async {
      var userId = 'userA';
      var result = await mock.getUser(userId);
      expect(result.id, userId);
    });
    test('register user', () async {
      var email = 'user@mail.com';
      var user = User();
      user.email = email;
      var result = await mock.registerUser(email, any, user);
      expect(result.email, email);
    });
    test('get user id', () async {
      var result = await mock.getUserId();
      expect(result, isInstanceOf<String>());
    });
  });
}