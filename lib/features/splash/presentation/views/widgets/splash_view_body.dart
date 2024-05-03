import 'package:couzinty/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage(context);
  }

  void navigateToNextPage(context) {
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).pushReplacement(AppRouter.kOnboardingView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.contain,
        ),
        Image.asset(
          'assets/images/logo-2.png',
          fit: BoxFit.contain,
        ),
        const CircularProgressIndicator(
          color: Colors.white,
        )
      ],
    );
  }
}
