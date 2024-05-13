import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:couzinty/features/auth/data/repos/auth_repo.dart';
import 'package:couzinty/features/auth/data/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;

  AuthRepoImpl(this._firebaseAuth, this._firestoreService);

  @override
  Future<void> firebaseSignUp(
      String userName, String email, String password) async {
    try {
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save userData on firestore
      await _firestoreService.saveUserData(
          userCredentials.user!.uid, userName, email, 'user');
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<UserModel?> firebaseSignIn(String email, String password) async {
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('dkhlt ll account');

      //get userData from firestore
      final user =
          await _firestoreService.getUserData(userCredentials.user!.uid);

      print('savit l data');

      return user!;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
