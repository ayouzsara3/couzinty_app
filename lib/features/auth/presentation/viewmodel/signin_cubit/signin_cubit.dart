import 'package:couzinty/features/auth/data/repos/auth_repo.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signin_cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Login Cubit
class SigninCubit extends Cubit<SigninState> {
  final AuthRepo authRepo;

  SigninCubit({required this.authRepo}) : super(SigninInitial());

  Future<void> login(String email, String password) async {
    emit(SigninLoading());
    try {
      final user = await authRepo.firebaseSignIn(email, password);
      emit(SigninSuccess(user: user!));
    } catch (e) {
      emit(SigninError("Login failed: $e"));
    }
  }
}
