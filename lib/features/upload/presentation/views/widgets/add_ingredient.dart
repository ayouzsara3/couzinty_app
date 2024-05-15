import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/upload_custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({super.key, required this.onSave});

  final Function onSave;

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  List ingrediantsWidgets = [1];

  List<String> ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingrédient",
            style: AppStyles.styleBold17(context),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ingrediantsWidgets.length,
              itemBuilder: (context, index) => enterIngerediant(index)),
          ingrediantsButton(),
        ],
      ),
    );
  }

  enterIngerediant(int index) {
    return Dismissible(
        key: GlobalKey(),
        direction: ingrediantsWidgets.length > 1
            ? DismissDirection.endToStart
            : DismissDirection.none,
        onDismissed: (direction) {
          setState(() {
            ingrediantsWidgets.removeAt(index);
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: UploadCustomTextFormField(
            radius: 30,
            hint: "Entrez l'ingrédient",
            icon: Icons.drag_indicator,
            onSave: (value) {
              ingredients.add(value);
              widget.onSave(ingredients);
            },
          ),
        ));
  }

  ingrediantsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          setState(() {});
          ingrediantsWidgets.add(enterIngerediant(1));
        },
        child: Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: kMainGreen),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: kDeepBlue,
                ),
                Text(
                  "Ingrédient",
                  style: TextStyle(
                      fontSize: 15,
                      color: kMainGreen,
                      fontWeight: FontWeight.w500),
                )
              ],
            )),
      ),
    );
  }
}
