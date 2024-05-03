import 'package:couzinty/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle styleMedium12(context) {
    return const TextStyle(
      color: kLightBlue,
      fontSize: 12,
      fontFamily: kMontserrat,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleBold17(context) {
    return const TextStyle(
      color: kDeepBlue,
      fontSize: 17,
      fontFamily: kMontserrat,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium15(context) {
    return const TextStyle(
      color: kLightBlue,
      fontSize: 15,
      fontFamily: kMontserrat,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleBold22(context) {
    return const TextStyle(
      color: kDarkBlue,
      fontSize: 22,
      fontFamily: kMontserrat,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium17(context) {
    return const TextStyle(
      color: kDeepBlue,
      fontSize: 15,
      fontFamily: kMontserrat,
      fontWeight: FontWeight.w500,
    );
  }
}
