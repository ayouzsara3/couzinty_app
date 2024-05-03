import 'package:couzinty/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(
        color: kLightBlue,
        fontSize: 15,
        fontFamily: kInter,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: kLightBlue,
        fontSize: 15,
        fontFamily: kInter,
        fontWeight: FontWeight.w500,
      ),
      iconColor: kDeepBlue,
      prefixIconColor: kDeepBlue,
      suffixIconColor: kLightBlue,
      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.9, color: kLightBlue),
        borderRadius: BorderRadius.circular(32),
      ),
      errorStyle: const TextStyle(fontSize: 12, color: Colors.redAccent),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.9, color: kLightBlue),
          borderRadius: BorderRadius.circular(32)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5, color: kMainGreen),
          borderRadius: BorderRadius.circular(32)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(32)),
      prefixStyle: const TextStyle(
        color: kLightBlue,
      ),
    ),
  );
}
