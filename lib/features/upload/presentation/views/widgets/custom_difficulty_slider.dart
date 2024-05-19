import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDifficultySlider extends StatefulWidget {
  const CustomDifficultySlider({super.key, required this.onSave});

  final Function onSave;

  @override
  State<CustomDifficultySlider> createState() => _CustomDifficultySliderState();
}

class _CustomDifficultySliderState extends State<CustomDifficultySlider> {
  late double slider = 2;

  double getsavedDifficulty(String difficulty) {
    switch (difficulty) {
      case 'Facile':
        return 1;
      case 'Moyen':
        return 2;
      case 'Difficile':
        return 3;
      default:
        return 2;
    }
  }

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
                    "Facile",
                    style: AppStyles.styleBold15(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "Moyen",
                    style: AppStyles.styleBold15(context)
                        .copyWith(color: kMainGreen),
                  ),
                  Text(
                    "Difficile",
                    style: AppStyles.styleBold15(context)
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
                  switch (slider) {
                    case 1:
                      widget.onSave('Facile');
                      break;
                    case 2:
                      widget.onSave('Moyen');
                      break;
                    case 3:
                      widget.onSave('Difficile');
                      break;
                    default:
                      widget.onSave('Moyen');
                  }
                })
          ],
        )
      ],
    );
  }
}
