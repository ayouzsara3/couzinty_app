import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:couzinty/features/auth/data/services/firestore_services.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  void navigateToNextPage() async {
    bool isLoggedIn = await _isLoggedIn();

    if (isLoggedIn) {
      final user = await _fetchUserInformation();

      context.read<UserCubit>().setUser(user!);

      if (user.role == 'user') {
        GoRouter.of(context).pushReplacement(AppRouter.kUserNavigation);
      } else {
        GoRouter.of(context).pushReplacement(AppRouter.kRecipesReviewView);
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {});

      GoRouter.of(context).pushReplacement(AppRouter.kSignInView);
    }
  }

  Future<UserModel?> _fetchUserInformation() async {
    try {
      final userId = getIt<FirebaseAuth>().currentUser!.uid;

      UserModel? userData = await getIt<FirestoreService>().getUserData(userId);

      return userData;
    } catch (e) {
      print('Error fetching user information: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Opacity(
          opacity: 0.1,
          child: Image.asset(
            'assets/images/background_image.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Image.asset(
          'assets/images/logo-2.png',
          height: 500,
        ),
      ],
    );
  }
}
