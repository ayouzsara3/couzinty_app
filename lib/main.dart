import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/features/auth/data/repos/auth_repo.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signin_cubit/signin_cubit.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signup/signup_cubit.dart';

import 'package:couzinty/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SigninCubit>(
            create: ((context) => SigninCubit(authRepo: getIt<AuthRepo>()))),
        BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(authRepo: getIt<AuthRepo>())),
        // Add more BlocProviders here if needed
      ],
      child: const Couzinty(),
    ),
  );
}

class Couzinty extends StatelessWidget {
  const Couzinty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
