import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tugas_akhir/data/user/user_data.dart';

class ProdUserRepository implements UserRepository {
  
  @override
  Future<User> fetchCurrentUser() {
    // TODO: implement fetchCurrentUser
    return null;
  }

  @override
  Future<User> fetchUser(String id) async {
    User user;
    Firestore.instance.collection('users').document(id).get().then((data) => {
      user = data as User
    });
    return user;
  }

  @override
  Future<User> loginUser(String email, String password) {
    // TODO: implement loginUser
    return null;
  }
}