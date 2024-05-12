import 'package:flutter/material.dart';

class CustomLoadingIncicator extends StatelessWidget {
  const CustomLoadingIncicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        height: 100, width: 100, 'assets/images/loading_indicator.apng');
  }
}
