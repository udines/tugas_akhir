import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/utils/shared_preferences.dart';

class ProdUserRepository implements UserRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = Firestore.instance.collection("users");
  
  @override
  Future<User> fetchCurrentUser() async {
    final fireUser = await _auth.currentUser();
    final snapshot = await _userCollection.document(fireUser.uid).get();
    return User.fromSnapshot(snapshot);
  }

  @override
  Future<User> loginUser(String email, String password) async {
    final fireUser = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final snapshot = await _userCollection.document(fireUser.uid).get();
    return User.fromSnapshot(snapshot);
  }

  @override
  Future<User> getUser(String uid) async {
    final user = await _userCollection.document(uid).get();
    return User.fromSnapshot(user);
  }

  @override
  Future<User> registerUser(String email, String password, User user) async {
    final fireUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    user.id = fireUser.uid;
    return user;
  }

  @override
  Future<bool> saveNewUserData(User user) async {
    await _userCollection.document(user.id).setData(user.toSnapshot())
      .catchError((e) => print(e));
    return true;
  }

  @override
  void saveUserInfo(User user) {
    SharedPref().saveString(SharedPref.KEY_USER_ID, user.id);
    SharedPref().saveString(SharedPref.KEY_USER_NAME, user.name);
    SharedPref().saveString(SharedPref.KEY_USER_ADDRESS, user.address);
    SharedPref().saveString(SharedPref.KEY_USER_PHONE, user.phone);
    SharedPref().saveBool(SharedPref.KEY_USER_ADMIN, user.isAdmin);
  }

  @override
  Future<void> logoutUser() {
    return _auth.signOut();
  }

  @override
  Future<String> getUserId() async {
    final fireUser = await _auth.currentUser();
    return fireUser.uid;
  }
}