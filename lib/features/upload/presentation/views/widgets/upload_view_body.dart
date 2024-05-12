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
import 'package:flutter/widgets.dart';
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';

class UploadViewBody extends StatefulWidget {
  const UploadViewBody({super.key});

  @override
  State<UploadViewBody> createState() => _UploadViewBodyState();
}

class _UploadViewBodyState extends State<UploadViewBody> {
  Text? selectedItem;

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
                  child: Text("Annuler",
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
                  "Nom de la recette",
                  style: AppStyles.styleBold22(context),
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadCustomTextFormField(
                  hint: "Entrez le nom de la recette",
                  radius: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Nombre des personnes ${selectedItem?.data ?? '..'}",
                  style: AppStyles.styleBold22(context),
                ),
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                    onPressed: _showItemSelector,
                    child: const Text('Select an Item')),
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

  void _showItemSelector() async {
    final selected = await showSpinnerItemSelector<Text>(
      context,
      items: const [
        Text('1'),
        Text('2'),
        Text('3'),
        Text('4'),
        Text('5'),
        Text('6'),
        Text('7'),
        Text('8'),
        Text('9'),
        Text('10'),
      ],
      buttonStyle: const ButtonStyle(
          textStyle: MaterialStatePropertyAll(TextStyle(color: kDarkBlue))),
      title: 'Nombre des personnes',
      spinnerBgColor: kMainGreen,
      selectedItemToWidget: (item) => item,
      nonSelectedItemToWidget: (item) =>
          Opacity(opacity: 0.4, child: item as Text),
      itemHeight: 50,
      height: 150,
      width: 100,
      spinnerHeight: 140,
      spinnerWidth: 90,
    );

    if (selected != null) {
      setState(() {
        selectedItem = selected;
      });
    }
  }
}
