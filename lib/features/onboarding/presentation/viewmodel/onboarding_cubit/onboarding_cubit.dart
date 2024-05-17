import 'package:bloc/bloc.dart';
import 'package:couzinty/features/onboarding/presentation/viewmodel/onboarding_cubit/onboarding_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  Future<void> checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool onboardingShown = prefs.getBool('onboardingShown') ?? false;

    if (onboardingShown) {
      emit(OnboardingShown());
    } else {
      emit(OnboardingNotShown());
    }
  }

  Future<void> setOnboardingShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingShown', true);
    emit(OnboardingShown());
  }
}
