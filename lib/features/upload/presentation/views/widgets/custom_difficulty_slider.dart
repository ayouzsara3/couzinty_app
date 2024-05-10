import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDifficultySlider extends StatefulWidget {
  const CustomDifficultySlider({super.key});

  @override
  State<CustomDifficultySlider> createState() => _CustomDifficultySliderState();
}

class _CustomDifficultySliderState extends State<CustomDifficultySlider> {
  double slider = 2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Difficulté de cuisson",
                style: AppStyles.styleBold22(context)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Facile",
                    style: AppStyles.styleBold17(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "Moyen",
                    style: AppStyles.styleBold17(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "Difficile",
                    style: AppStyles.styleBold17(context)
                        .copyWith(color: kMainGreen),
                  ),
                ],
              ),
            ),
            Slider(
                divisions: 2,
                activeColor: kMainGreen,
                thumbColor: kMainGreen,
                max: 3,
                min: 1,
                value: slider,
                onChanged: (value) {
                  setState(() {
                    slider = value;
                  });
                })
          ],
        )
      ],
    );
  }
}
