import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepository {
  Future<User> fetchCurrentUser();
  Future<User> loginUser(String email, String password);
  Future<void> registerUser(String email, String password, User user);
  Future<User> getUser(String uid);
  Future<void> logoutUser();
  Future<String> getUserId();
  void saveUserInfo(User user);
}

class User {
  String id;
  String email;
  String name;
  String address;
  String city;
  String postalCode;
  String phone;
  bool isAdmin;

  User({
    this.id = '',
    this.email,
    this.name, 
    this.address, 
    this.city = '',
    this.postalCode = '',
    this.phone, 
    this.isAdmin = false
  });

  Map<String, dynamic> toSnapshot() => {
    'id': id,
    'email': email,
    'name': name,
    'address': address,
    'city': city,
    'postalCode': postalCode,
    'phone': phone,
    'isAdmin': isAdmin
  };

  User.fromSnapshot(DocumentSnapshot snapshot) :
    id = snapshot['id'],
    email = snapshot['email'],
    name = snapshot['name'],
    address = snapshot['address'],
    city = snapshot['city'],
    postalCode = snapshot['postalCode'],
    phone = snapshot['phone'],
    isAdmin = snapshot['isAdmin'];
}