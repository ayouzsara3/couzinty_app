import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

class UploadCustomTextFormField extends StatelessWidget {
  UploadCustomTextFormField(
      {super.key,
      this.maxLines = 1,
      this.icon,
      required this.hint,
      this.radius = 10});
  int maxLines;
  IconData? icon;
  String hint;
  double radius;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        icon: icon == null ? null : Icon(icon),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: kLightBlue),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: kLightBlue)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: kLightBlue)),
      ),
    );
  }
}
