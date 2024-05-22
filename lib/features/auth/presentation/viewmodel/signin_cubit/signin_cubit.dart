import 'package:couzinty/features/auth/data/repos/auth_repo.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signin_cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepo authRepo;

  SigninCubit({required this.authRepo}) : super(SigninInitial());

  Future<void> login(String email, String password) async {
    emit(SigninLoading());

    final user = await authRepo.firebaseSignIn(email, password);
    user.fold((failure) async {
      emit(SigninError(failure));
    }, (user) async {
      await _updateSharedPreferences(true);
      emit(SigninSuccess(user: user));
    });
  }

  Future<void> logout() async {
    await _updateSharedPreferences(false);
    emit(SigninInitial());
  }

  void resetState() {
    emit(SigninInitial());
  }

  Future<void> _updateSharedPreferences(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
