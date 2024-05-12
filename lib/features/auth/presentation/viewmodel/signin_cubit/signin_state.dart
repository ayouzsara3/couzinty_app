import 'package:couzinty/features/auth/data/models/user_model.dart';

abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {
  final UserModel user;

  SigninSuccess({required this.user});
}

class SigninError extends SigninState {
  final String errorMessage;

  SigninError(this.errorMessage);
}
