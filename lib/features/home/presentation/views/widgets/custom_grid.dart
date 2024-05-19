import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/home/presentation/viewmodel/suggestion_recipes_cubit.dart/suggestion_recipes_cubit.dart';
import 'package:couzinty/features/home/presentation/viewmodel/suggestion_recipes_cubit.dart/suggestion_recipes_state.dart';
import 'package:couzinty/features/home/presentation/views/widgets/suggest_recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestionRecipesCubit, SuggestionRecipesState>(
      builder: (context, state) {
        if (state is SuggestionRecipesSuccess) {
          if (state.recipes.isEmpty) {
            context.read<SuggestionRecipesCubit>().fetchRandomRecipes();
          }

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 32,
              mainAxisSpacing: 10,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return SuggestRecipeCard(recipe: state.recipes[index]);
            },
          );
        } else {
          return const Center(
            child: CustomLoadingIncicator(),
          );
        }
      },
    );
  }
}
