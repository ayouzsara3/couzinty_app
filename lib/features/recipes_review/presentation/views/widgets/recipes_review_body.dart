import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/categories/presentation/views/widgets/recipe_card.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/fetch_pending_recipes/fetchpendingrecipes_cubit.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/fetch_pending_recipes/fetchpendingrecipes_state.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/recipe_action_cubit/recipe_action_cubit.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesReviewBody extends StatefulWidget {
  const RecipesReviewBody({super.key});

  @override
  State<RecipesReviewBody> createState() => _RecipesReviewBodyState();
}

class _RecipesReviewBodyState extends State<RecipesReviewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchPendingRecipesCubit>().fetchPendingRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<FetchPendingRecipesCubit, FetchPendingRecipesState>(
        builder: (context, state) {
          if (state is FetchPendingRecipesError) {
            return Center(
              child: Text("Erreur: ${state.message}"),
            );
          } else if (state is FetchPendingRecipesSuccess) {
            if (state.recipes.isEmpty) {
              return const Center(
                child: Text('aucune recette trouvée'),
              );
            } else {
              print('tool ${state.recipes.length}');
              return _buildPendingRecipesResult(state.recipes);
            }
          } else {
            return const Center(
              child: CustomLoadingIncicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildPendingRecipesResult(List<RecipeModel> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return Dismissible(
          secondaryBackground: Container(
            color: kMainGreen,
            alignment: Alignment.centerRight,
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                CupertinoIcons.check_mark,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                CupertinoIcons.xmark,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          key: GlobalKey(),
          // direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              await context.read<RecipeActionCubit>().performRecipeAction(
                  action: 'delete', recipeId: recipes[index].id);
            } else {
              await context.read<RecipeActionCubit>().performRecipeAction(
                  action: 'accept', recipeId: recipes[index].id);
            }
            setState(() {});
          },
          child: RecipeCard(
            recipe: recipes[index],
          ),
        );
      },
    );
  }
}
