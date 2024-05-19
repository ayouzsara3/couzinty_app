import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDurationSlider extends StatefulWidget {
  const CustomDurationSlider({super.key, required this.onSave});

  final Function onSave;

  @override
  State<CustomDurationSlider> createState() => _CustomDurationSliderState();
}

class _CustomDurationSliderState extends State<CustomDurationSlider> {
  late double slider = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "10",
                    style: AppStyles.styleBold15(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "30",
                    style: AppStyles.styleBold15(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "50",
                    style: AppStyles.styleBold15(context)
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
                    widget.onSave(value);
                  });
                })
          ],
        )
      ],
    );
  }
}
