import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:couzinty/features/auth/data/repos/auth_repo.dart';
import 'package:couzinty/features/auth/data/services/firestore_services.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;

  AuthRepoImpl(this._firebaseAuth, this._firestoreService);

  @override
  Future<Either<String, Unit>> firebaseSignUp(
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

      return right(unit);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        return left('cet adresse mail est déjà utilisée');
      }
      return left('Authentification échouée');
    }
  }

  @override
  Future<Either<String, UserModel>> firebaseSignIn(
      String email, String password) async {
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //get userData from firestore
      final user =
          await _firestoreService.getUserData(userCredentials.user!.uid);

      return right(user!);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-credential') {
        return left('Email ou mot de passe invalide');
      }
      return left(error.message!);
    }
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
