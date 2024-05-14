import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundGreen,
      body: SplashViewBody(),
    );
  }
}
