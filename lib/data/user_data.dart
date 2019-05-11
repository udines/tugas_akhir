class User {
  String id;
  String name;
  String address;
  String phone;

  User({this.id, this.name, this.address, this.phone});
}

abstract class UserRepository {
  Future<List<User>> fetchUsers();
  Future<User> fetchCurrentUser();
  Future<User> fetchUser(String id);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}