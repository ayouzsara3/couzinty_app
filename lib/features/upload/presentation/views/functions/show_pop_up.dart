import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/widgets/custom_button.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> showPopUp(BuildContext context) {
  final userRole = context.read<UserCubit>().state.role;

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
                  userRole == 'user'
                      ? Text(
                          "Nous l'examinerons bientôt",
                          textAlign: TextAlign.center,
                          style: AppStyles.styleBold15(context),
                        )
                      : Container(),
                  CustomButton(
                      backgroundColor: kMainGreen,
                      color: Colors.white,
                      borderRadius: 32,
                      onTap: () {
                        if (userRole == 'user') {
                          GoRouter.of(context)
                              .pushReplacement(AppRouter.kUserNavigation);
                        } else {
                          GoRouter.of(context)
                              .pushReplacement(AppRouter.kRecipesReviewView);
                        }
                      },
                      text: "Retour")
                ],
              ),
            ),
          ));
}
