import 'user_data.dart';

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
}

var users = <User>[
  new User(
    id: "userA",
    name: "Farhan",
    address: "Jalan Sukabirus No. 418",
    phone: "08976378464"
  ),
  new User(
      id: "userB",
      name: "Aisyah",
      address: "Perumahan paradice no. F20",
      phone: "08976378464"
  ),
  new User(
      id: "userC",
      name: "Karisma",
      address: "Pogung dalangan RT 50",
      phone: "08976378464"
  ),
];
