import 'package:tugas_akhir/data/user/user_data.dart';

class MockUserRepository implements UserRepository{

  @override
  Future<User> fetchCurrentUser() {
    return Future.value(users[1]);
  }

  @override
  Future<User> getUser(String uid) {
    return Future.value(
      users.firstWhere(
        (user) => user.id == uid
      )
    );
  }

  @override
  Future<User> loginUser(String email, String password) {
    return Future.value(
      users.firstWhere(
          (user) => user.email == email
      )
    );
  }

  @override
  Future<User> registerUser(String email, String password, User user) {
    return Future.value(
      users.firstWhere(
          (user) => user.email == email
      )
    );
  }

  @override
  Future<String> getUserId() {
    return Future.value(users[1].id);
  }

  @override
  Future<bool> saveNewUserData(User user) {
    return Future.value(true);
  }

  @override
  Future<void> saveUserInfo(User user) {
    return Future.value(true);
  }

  @override
  Future<void> logoutUser() {
    return Future.value(true);
  }
}

var users = <User>[
  User(
    id: "userA",
    name: "Farhan",
    address: "Jalan Sukabirus No. 418",
    phone: "08976378464",
    isAdmin: true,
    email: 'user@mail.com'
  ),
  User(
    id: "userB",
    name: "Aisyah",
    address: "Perumahan paradice no. F20",
    phone: "08976378464",
    isAdmin: false,
    email: 'user@email.com'
  ),
  User(
    id: "userC",
    name: "Karisma",
    address: "Pogung dalangan RT 50",
    phone: "08976378464",
    isAdmin: false
  ),
];
