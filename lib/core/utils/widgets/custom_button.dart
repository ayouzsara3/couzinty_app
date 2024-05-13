import 'package:flutter/material.dart';

import '../size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.fontSize,
    this.isLoading = false,
    this.borderRadius,
  });
  final String? text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? fontSize;
  final bool? isLoading;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 60,
        width: width ?? SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        child: Center(
          child: isLoading!
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text!,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    required this.text,
    required this.onTap,
    this.iconData,
    this.color,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.fontSize,
    this.isLoading = false,
    this.borderRadius,
  });
  final String text;
  final IconData? iconData;
  final VoidCallback onTap;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool? isLoading;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 60,
        width: width ?? SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          border:
              Border.all(color: borderColor ?? Colors.transparent, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (isLoading)!
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: fontSize,
                          color: color,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        iconData,
                        color: color,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
