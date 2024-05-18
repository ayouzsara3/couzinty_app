import 'dart:io';

import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:couzinty/core/utils/widgets/custom_button.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:couzinty/features/upload/presentation/viewmodel/upload_cubit/upload_cubit.dart';
import 'package:couzinty/features/upload/presentation/viewmodel/upload_cubit/upload_state.dart';
import 'package:couzinty/features/upload/presentation/views/functions/show_pop_up.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/add_ingredient.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/add_photo.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/add_rating.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/add_steps.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/custom_category_dropdown.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/custom_difficulty_slider.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/custom_duration_slider.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/upload_custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';

class UploadViewBody extends StatefulWidget {
  const UploadViewBody({super.key});

  @override
  State<UploadViewBody> createState() => _UploadViewBodyState();
}

class _UploadViewBodyState extends State<UploadViewBody> {
  String? recipeName;
  File? recipeImage;
  String? selectedCategory;
  String selectedDifficulty = 'Moyen';
  double selectedCookingTime = 30;
  List<String> ingredients = [];
  List<String> instructions = [];
  double? selectedRate = 3;
  Text personsNumber = const Text('1');

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddPhoto(
                        onPickImage: (value) {
                          recipeImage = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Nom de la recette",
                        style: AppStyles.styleBold17(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UploadCustomTextFormField(
                        hint: "Entrez le nom de la recette",
                        radius: 30,
                        onSave: (value) {
                          setState(() {
                            recipeName = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Categorie",
                        style: AppStyles.styleBold17(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomCategoryDropDown(onSave: (value) {
                        selectedCategory = value;
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Nombre des personnes ${personsNumber.data ?? '..'}",
                        style: AppStyles.styleBold17(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(kMainGreen)),
                              onPressed: _showItemSelector,
                              child: const Text(
                                'Choisissez le Nombre',
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomDifficultySlider(
                        onSave: (value) {
                          selectedDifficulty = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomDurationSlider(
                        onSave: (value) {
                          selectedCookingTime = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddIngredient(
                        onSave: (value) {
                          ingredients = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddSteps(
                        onSave: (value) {
                          instructions = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Evaluation",
                        style: AppStyles.styleBold17(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddRating(
                        onSave: (value) {
                          selectedRate = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onTap: () async {
                          final isValid = _formKey.currentState!.validate();
                          if (!isValid || recipeImage == null) {
                            return;
                          }

                          instructions.clear();
                          ingredients.clear();

                          _formKey.currentState!.save();

                          final userRole = context.read<UserCubit>().state.role;
                          final userId = context.read<UserCubit>().state.id;

                          await context.read<UploadCubit>().uploadRecipe(
                              name: recipeName,
                              image: recipeImage,
                              category: selectedCategory,
                              cookingTime: selectedCookingTime.toInt(),
                              difficulty: selectedDifficulty,
                              ingredients: ingredients,
                              instructions: instructions,
                              personsNumber: int.tryParse(personsNumber.data!),
                              rate: selectedRate,
                              userRole: userRole,
                              userId: userId);
                        },
                        text: "Ajouter",
                        fontSize: 18,
                        color: Colors.white,
                        backgroundColor: kMainGreen,
                        borderRadius: 32,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        BlocBuilder<UploadCubit, UploadState>(
          builder: (context, state) {
            if (state is UploadLoading) {
              return Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                color: Colors.black.withOpacity(0.2), // Add some blur effect
                child: const Center(
                  child: CustomLoadingIncicator(), // Loading indicator
                ),
              );
            }
            if ((state is UploadSuccess)) {
              Future.delayed(Duration.zero, () {
                // Show dialog when upload is successful
                showPopUp(context);
              });
            } else {
              return const SizedBox.shrink();
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void _showItemSelector() async {
    final selected = await showSpinnerItemSelector<Text>(
      context,
      items: [
        Text(
          '1',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '2',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '3',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '4',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '5',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '6',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '7',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '8',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '9',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
        Text(
          '10',
          style: AppStyles.styleBold17(context).copyWith(color: Colors.white),
        ),
      ],
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
        personsNumber = selected;
      });
    }
  }
}
