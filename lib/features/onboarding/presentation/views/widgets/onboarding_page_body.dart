import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/size_config.dart';

class OnboardingPageBody extends StatelessWidget {
  const OnboardingPageBody(
      {super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight! - 350,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kDarkBlue,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kLightBlue,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
