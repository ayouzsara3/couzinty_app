import 'package:carousel_slider/carousel_slider.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class HomeCustomSlider extends StatelessWidget {
  const HomeCustomSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [1, 2, 3, 4, 5].map((e) {
          return Container(
            width: SizeConfig.screenHeight,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Center(
              child: Text('Slider $e'),
            ),
          );
        }).toList(),
        options: CarouselOptions(height: 200, autoPlay: true));
  }
}
