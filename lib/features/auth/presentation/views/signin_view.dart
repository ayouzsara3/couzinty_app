import 'package:couzinty/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Opacity(
          opacity: 0.3,
          child: Image.asset(
            'assets/images/login_background.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        const SignInViewBody(),
      ]),
    );
  }
}
