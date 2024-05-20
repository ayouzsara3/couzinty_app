import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, Unit>> firebaseSignUp(
      String userName, String email, String password);
  Future<Either<String, UserModel>> firebaseSignIn(
      String email, String password);
  Future<void> logout();
}
