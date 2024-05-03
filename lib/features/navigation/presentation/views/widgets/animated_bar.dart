import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: kMainGreen,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ), // BoxDecoration
    ); // Animated Container
  }
}
