import 'package:couzinty/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<void> firebaseSignUp(String userName, String email, String password);
  Future<UserModel?> firebaseSignIn(String email, String password);
  Future<void> logout();
}
