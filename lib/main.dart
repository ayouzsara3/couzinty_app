import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/core/utils/functions/simple_bloc_observer.dart';
import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:couzinty/features/auth/data/repos/auth_repo_impl.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signin_cubit/signin_cubit.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signup/signup_cubit.dart';
import 'package:couzinty/features/categories/data/repos/category_repo_impl.dart';
import 'package:couzinty/features/categories/presentation/viewmodel/fetch_recipes_by_category_cubit/fetch_recipes_by_category_cubit.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';

import 'package:couzinty/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';

import 'core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  await setupServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SigninCubit>(
            create: ((context) =>
                SigninCubit(authRepo: getIt<AuthRepoImpl>()))),
        BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(authRepo: getIt<AuthRepoImpl>())),

        BlocProvider<UserCubit>(
          create: (context) => UserCubit(UserModel(
            id: '', // Provide initial values for your UserModel fields
            email: '',
            userName: '',
            role: '',
            image: '',
            favorites: [],
            shoppingList: [],
          )),
        ),
        BlocProvider<FetchRecipesByCategoryCubit>(
          create: (context) =>
              FetchRecipesByCategoryCubit(getIt<CategoryRepoImpl>()),
        )
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
      builder: EasyLoading.init(),
    );
  }
}
