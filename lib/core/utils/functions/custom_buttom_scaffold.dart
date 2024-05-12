import 'package:couzinty/core/utils/size_config.dart';
import 'package:flutter/material.dart';

void customScaffold(
  context,
  String message,
  Color color,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1000),
    margin: EdgeInsets.only(
      bottom: SizeConfig.screenHeight! - 90,
      left: 10,
      right: 10,
    ),
    backgroundColor: color,
    showCloseIcon: true,
  ));
}
