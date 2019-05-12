import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_data.dart';

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
}