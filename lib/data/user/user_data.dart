import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepository {
  Future<User> fetchCurrentUser();
  Future<User> loginUser(String email, String password);
  Future<void> registerUser(String email, String password, User user);
  Future<User> getUser(String uid);
}

class User {
  String id;
  String name;
  String address;
  String phone;
  bool isAdmin;

  User({this.id, this.name, this.address, this.phone, this.isAdmin = false});

  Map<String, dynamic> toSnapshot() => {
    'id': id,
    'name': name,
    'address': address,
    'phone': phone,
    'isAdmin': isAdmin
  };

  User.fromSnapshot(DocumentSnapshot snapshot) :
    id = snapshot['id'],
    name = snapshot['name'],
    address = snapshot['address'],
    phone = snapshot['phone'],
    isAdmin = snapshot['isAdmin'];
}