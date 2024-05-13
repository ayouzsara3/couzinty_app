import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/data/categories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCategoryDropDown extends StatefulWidget {
  const CustomCategoryDropDown({super.key, required this.onSave});

  final Function onSave;

  @override
  State<CustomCategoryDropDown> createState() => _CustomCategoryDropDownState();
}

class _CustomCategoryDropDownState extends State<CustomCategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: (value) {
        if (value == null) {
          return 'Veuillez sélectionner une catégorie';
        }
        return null;
      },
      hint: Text(
        'Catégorie de recette',
        style: AppStyles.styleMedium17(context).copyWith(color: kLightBlue),
      ),
      items: [
        for (final category in categories)
          DropdownMenuItem(
            value: category.name,
            child: Row(children: [
              Text(category.name),
            ]),
          )
      ],
      onChanged: (value) {
        setState(() {
          widget.onSave(value);
        });
      },
      onSaved: (newValue) {
        widget.onSave(newValue);
      },
    );
  }
}
