import 'package:couzinty/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: SignUpViewBody(),
    );
  }
}
