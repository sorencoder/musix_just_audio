import 'package:firebase_auth/firebase_auth.dart';
import 'package:musix/data/model/user_model.dart';
import 'package:musix/services/firebase_service.dart';

class UserRepository {
  final auth = FirebaseService.auth;
  final firestore = FirebaseService.firestore;
  UserCredential? credential;

  /// Creates a new user account with email and password.
  ///
  /// Parameters:
  /// - [email]: The email address of the new user.
  /// - [password]: The password for the new user account.
  ///
  /// Returns:
  /// - A [UserModel] representing the created user.
  Future<UserModel> createAccount(
      String email, String password, String name) async {
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential == null || credential!.user == null) {
        throw Exception("User creation failed. No credentials returned.");
      }

      final userId = credential!.user!.uid;
      final newUser = UserModel(
        name: name, // Default name; consider updating with user input.
        email: email,
        id: userId,
      );

      await firestore.collection('users').doc(userId).set(newUser.toMap());

      return newUser;
    } catch (e) {
      // Optionally log the error or handle it as needed.
      print('Error creating account: $e');
      rethrow;
    }
  }

  /// Signs in a user with email and password.
  ///
  /// Parameters:
  /// - [email]: The email address of the user.
  /// - [password]: The password for the user account.
  ///
  /// Returns:
  /// - A [UserModel] representing the signed-in user.
  Future<UserModel> signIn(String email, String password) async {
    try {
      credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential == null || credential!.user == null) {
        throw Exception("Sign-in failed. No credentials returned.");
      }

      final userId = credential!.user!.uid;
      final userDoc = await firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception("User not found in Database.");
      }

      final userModel =
          UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      return userModel;
    } catch (e) {
      // Optionally log the error or handle it as needed.
      print('Error signing in: $e');
      rethrow;
    }
  }
}
