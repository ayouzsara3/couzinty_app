import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle styleMedium12(context) {
    return const TextStyle(
      color: kLightBlue,
      fontSize: 12,
      fontFamily: kInter,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleBold15(context) {
    return const TextStyle(
      color: kDarkBlue,
      fontSize: 15,
      fontFamily: kInter,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold17(context) {
    return const TextStyle(
      color: kDeepBlue,
      fontSize: 17,
      fontFamily: kInter,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium15(context) {
    return const TextStyle(
      color: kLightBlue,
      fontSize: 15,
      fontFamily: kInter,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleBold22(context) {
    return const TextStyle(
      color: kDeepBlue,
      fontSize: 22,
      fontFamily: kInter,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleMedium17(context) {
    return const TextStyle(
      color: kDeepBlue,
      fontSize: 15,
      fontFamily: kInter,
      fontWeight: FontWeight.w500,
    );
  }
}
