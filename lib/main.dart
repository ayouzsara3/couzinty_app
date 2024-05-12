import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/features/auth/data/repos/auth_repo.dart';
import 'package:couzinty/features/auth/data/repos/auth_repo_impl.dart';
import 'package:couzinty/features/auth/data/services/firestore_services.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signup/signup_cubit.dart';
import 'package:couzinty/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirestoreService firestoreService = FirestoreService(firestore: firestore);

  AuthRepo authRepo = AuthRepoImpl(firebaseAuth, firestoreService);

  runApp(
    BlocProvider(
      create: (context) => SignupCubit(authRepo: authRepo),
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
