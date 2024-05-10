import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddPhoto extends StatelessWidget {
  const AddPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: DottedBorder(
          dashPattern: const [15, 5],
          color: kLightBlue,
          strokeWidth: 2,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          child: SizedBox(
            width: double.infinity,
            height: 160,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.photo,
                    size: 65,
                    color: kLightBlue,
                  ),
                  Text(
                    "Ajouter une photo",
                    style: AppStyles.styleBold15(context),
                  ),
                  const Spacer()
                ],
              ),
            ),
          )),
    );
  }
}
