import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDurationSlider extends StatefulWidget {
  const CustomDurationSlider({super.key});

  @override
  State<CustomDurationSlider> createState() => _CustomDurationSliderState();
}

class _CustomDurationSliderState extends State<CustomDurationSlider> {
  double slider = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Durée de cuisson", style: AppStyles.styleBold22(context)),
            Text("( en minutes )", style: AppStyles.styleMedium17(context)),
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
                    "10",
                    style: AppStyles.styleBold17(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "30",
                    style: AppStyles.styleBold17(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "50",
                    style: AppStyles.styleBold17(context)
                        .copyWith(color: kMainGreen),
                  ),
                ],
              ),
            ),
            Slider(
                divisions: 8,
                activeColor: kMainGreen,
                thumbColor: kMainGreen,
                max: 50,
                min: 10,
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
