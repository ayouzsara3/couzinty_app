import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> showPopUp(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              padding: const EdgeInsets.all(10),
              height: 400,
              width: 327,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/done.png"),
                  Text(
                    "Envoyé avec succès",
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold22(context),
                  ),
                  Text(
                    "Votre recette a été envoyée",
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold15(context),
                  ),
                  Text(
                    "Nous l'examinerons bientôt",
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold15(context),
                  ),
                  CustomButton(
                      backgroundColor: kMainGreen,
                      color: Colors.white,
                      borderRadius: 32,
                      onTap: () {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kUserNavigation);
                      },
                      text: "Retour")
                ],
              ),
            ),
          ));
}
