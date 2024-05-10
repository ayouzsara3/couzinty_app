import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/widgets/custom_button.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/add_ingredient.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/add_photo.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/add_steps.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/custom_difficulty_slider.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/custom_duration_slider.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/upload_custom_text_form_field.dart';
import 'package:flutter/material.dart';

class UploadViewBody extends StatelessWidget {
  const UploadViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel",
                      style: AppStyles.styleBold17(context)
                          .copyWith(color: Colors.redAccent)),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddPhoto(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Food Name",
                  style: AppStyles.styleBold22(context),
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadCustomTextFormField(
                  hint: "Enter food name",
                  radius: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomDifficultySlider(),
                const SizedBox(
                  height: 20,
                ),
                const CustomDurationSlider(),
                const SizedBox(
                  height: 20,
                ),
                const AddIngredient(),
                const SizedBox(
                  height: 20,
                ),
                const AddSteps(),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () {},
                  text: "Ajouter",
                  fontSize: 18,
                  color: Colors.white,
                  backgroundColor: kMainGreen,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
