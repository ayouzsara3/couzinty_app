import 'package:couzinty/core/utils/widgets/custom_fade_transition.dart';
import 'package:couzinty/features/auth/presentation/views/signin_view.dart';
import 'package:couzinty/features/auth/presentation/views/signup_view.dart';
import 'package:couzinty/features/navigation/presentation/views/user_navigation.dart';
import 'package:couzinty/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kOnboardingView = '/onboardingview';
  static const kSignUpView = '/signupview';
  static const kSignInView = '/signinview';
  static const kUserNavigation = '/usernavigation';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        pageBuilder: (context, state) {
          return customFadeTransition(state, const OnboardingView());
        },
      ),
      GoRoute(
        path: kSignUpView,
        pageBuilder: (context, state) {
          return customFadeTransition(state, const SignUpView());
        },
      ),
      GoRoute(
        path: kSignInView,
        pageBuilder: (context, state) {
          return customFadeTransition(state, const SignInView());
        },
      ),
      GoRoute(
        path: kUserNavigation,
        pageBuilder: (context, state) {
          return customFadeTransition(state, const UserNavigation());
        },
      ),
    ],
  );
}
