import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/upload_custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({super.key});

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  List ingrediants = [1];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingrediant",
            style: AppStyles.styleBold22(context),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ingrediants.length,
              itemBuilder: (context, index) => enterIngerediant(index)),
          ingrediantsButton(),
        ],
      ),
    );
  }

  enterIngerediant(int index) {
    return Dismissible(
        key: GlobalKey(),
        direction: ingrediants.length > 1
            ? DismissDirection.endToStart
            : DismissDirection.none,
        onDismissed: (direction) {
          setState(() {
            ingrediants.removeAt(index);
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: UploadCustomTextFormField(
            radius: 30,
            hint: "Enter Ingrerdiant",
            icon: Icons.drag_indicator,
          ),
        ));
  }

  ingrediantsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          setState(() {});
          ingrediants.add(enterIngerediant(1));
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
                  "Ingrediant",
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
