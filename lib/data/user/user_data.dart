class User {
  String id;
  String name;
  String address;
  String phone;
  bool isAdmin;

  User({this.id, this.name, this.address, this.phone, this.isAdmin});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'address': address,
    'phone': phone,
    'isAdmin': isAdmin
  };
}

abstract class UserRepository {
  Future<User> fetchCurrentUser();
  Future<User> fetchUser(String id);
  Future<User> loginUser(String email, String password);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}