import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/widgets/custom_button.dart';
import 'package:couzinty/features/search/presentation/views/widgets/custom_category_list.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/custom_difficulty_slider.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/custom_duration_slider.dart';
import 'package:flutter/material.dart';

class CustomFilter extends StatefulWidget {
  final Function(String?, double?, String?) onChoosenFilter;

  const CustomFilter({
    super.key,
    required this.onChoosenFilter,
  });

  @override
  CustomFilterState createState() => CustomFilterState();
}

class CustomFilterState extends State<CustomFilter> {
  String? selectedDifficulty = 'Moyen';
  double? selectedCookingTime = 30;
  String? selectedCategory = 'Entrées';

  bool isCategoryChecked = false;
  bool isCookingTimeChecked = false;
  bool isDifficultyChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Choisir un filtre",
                    style: AppStyles.styleBold17(context),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Categories",
                        style: AppStyles.styleBold17(context),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: isCategoryChecked,
                        onChanged: (value) {
                          setState(() {
                            isCategoryChecked = value!;
                          });
                        },
                        activeColor: kMainGreen,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (isCategoryChecked)
                    CustomCategoriesList(
                      onSave: (value) {
                        selectedCategory = value;
                      },
                    ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text("Durée de cuisson",
                          style: AppStyles.styleBold17(context)),
                      Text("( en minutes )",
                          style: AppStyles.styleMedium17(context)),
                      const Spacer(),
                      Checkbox(
                        value: isCookingTimeChecked,
                        onChanged: (value) {
                          setState(() {
                            isCookingTimeChecked = value!;
                          });
                        },
                        activeColor: kMainGreen,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (isCookingTimeChecked)
                    CustomDurationSlider(
                      onSave: (value) {
                        selectedCookingTime = value;
                      },
                    ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Difficulté de cuisson",
                        style: AppStyles.styleBold17(context),
                        textAlign: TextAlign.left,
                      ),
                      const Spacer(),
                      Checkbox(
                        value: isDifficultyChecked,
                        onChanged: (value) {
                          setState(() {
                            isDifficultyChecked = value!;
                          });
                        },
                        activeColor: kMainGreen,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (isDifficultyChecked)
                    CustomDifficultySlider(
                      onSave: (value) {
                        selectedDifficulty = value;
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {
                    widget.onChoosenFilter('Entrées', 30.toDouble(), 'Moyen');
                    Navigator.pop(context);
                  },
                  text: "Annuler",
                  color: kDarkBlue,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    widget.onChoosenFilter(
                      isCategoryChecked ? selectedCategory : null,
                      isCookingTimeChecked ? selectedCookingTime : null,
                      isDifficultyChecked ? selectedDifficulty : null,
                    );
                    Navigator.pop(context);
                  },
                  text: "Fait",
                  borderRadius: 32,
                  color: Colors.white,
                  backgroundColor: kMainGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
