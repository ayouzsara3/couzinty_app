import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      GoRouter.of(context).pushReplacement(AppRouter.kSignUpView);
    });
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
