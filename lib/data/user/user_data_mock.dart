import 'package:tugas_akhir/data/user/user_data.dart';

class MockUserRepository implements UserRepository {

  @override
  Future<User> fetchCurrentUser() {
    return new Future.value(users[0]);
  }

  @override
  Future<User> fetchUser(String id) {
    return new Future.value(
      users.firstWhere(
        (user) => user.id == id
      )
    );
  }

  @override
  Future<User> loginUser(String email, String password) {
    return new Future.value(users[0]);
  }
}

var users = <User>[
  User(
    id: "userA",
    name: "Farhan",
    address: "Jalan Sukabirus No. 418",
    phone: "08976378464",
    isAdmin: true
  ),
  User(
    id: "userB",
    name: "Aisyah",
    address: "Perumahan paradice no. F20",
    phone: "08976378464",
    isAdmin: false
  ),
  User(
    id: "userC",
    name: "Karisma",
    address: "Pogung dalangan RT 50",
    phone: "08976378464",
    isAdmin: false
  ),
];
