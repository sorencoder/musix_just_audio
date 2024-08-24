import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musix/data/model/user_model.dart';

class UserRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  UserCredential? credential;

  Future<UserModel> createAccount(String email, String password) async {
    late UserModel newUser;
    try {
      credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential != null) {
        newUser =
            UserModel(name: "name", email: email, id: credential!.user!.uid);
        firestore
            .collection('users')
            .doc(credential!.user!.uid)
            .set(newUser.toMap());
      }
      return newUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    late UserModel userModel;
    try {
      credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential != null) {
        DocumentSnapshot userData = await firestore
            .collection('users')
            .doc(credential!.user!.uid)
            .get();
        userModel = UserModel.fromMap(userData.data() as Map<String, dynamic>);
      }
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
