import 'package:couzinty/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import '../../../../../core/utils/size_config.dart';
import 'onboarding_page_body.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return OnBoardingSlider(
      onFinish: () async {},
      finishButtonText: 'Commencer',
      finishButtonStyle: const FinishButtonStyle(
          backgroundColor: kMainGreen,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
      skipTextButton: const Text(
        'Sauter',
        style: TextStyle(
          fontSize: 16,
          color: kMainGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
      controllerColor: kMainGreen,
      centerBackground: true,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Image.asset(
          'assets/images/onboarding-1.png',
        ),
        Image.asset(
          'assets/images/onboarding-2.png',
        ),
        Image.asset(
          'assets/images/onboarding-3.png',
        ),
      ],
      speed: 1.9,
      pageBodies: const [
        OnboardingPageBody(
          title: 'Trouvez la Recette Parfaite',
          subTitle:
              'Explorez notre collection pour des recettes rapides et délicieuses.',
        ),
        OnboardingPageBody(
          title: 'Rassemblez les Ingrédients',
          subTitle: 'Consultez la liste et préparez-vous à cuisiner.',
        ),
        OnboardingPageBody(
          title: 'Commencez la Cuisson',
          subTitle: 'Suivez les instructions pour un repas délicieux.',
        ),
      ],
    );
  }
}