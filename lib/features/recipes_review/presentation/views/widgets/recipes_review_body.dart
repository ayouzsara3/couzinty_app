import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/categories/presentation/views/widgets/recipe_card.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/fetch_recipes/fetch_recipes_cubit.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/fetch_recipes/fetch_recipes_state.dart';
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
  var _selectedTab = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchRecipesCubit>().fetchPendingRecipes('pending');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedTab = 1;
                      context
                          .read<FetchRecipesCubit>()
                          .fetchPendingRecipes('pending');
                    });
                  },
                  child: Text('En attente',
                      style: TextStyle(
                          color: _selectedTab == 1 ? kDarkBlue : kLightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))),
              SizedBox(width: SizeConfig.defaultSize),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = 2;
                    context
                        .read<FetchRecipesCubit>()
                        .fetchPendingRecipes('accepted');
                  });
                },
                child: Text('Accepté',
                    style: TextStyle(
                        color: _selectedTab == 2 ? kDarkBlue : kLightBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(width: SizeConfig.defaultSize! * 5),
          Expanded(
            child: BlocBuilder<FetchRecipesCubit, FetchRecipesState>(
              builder: (context, state) {
                if (state is FetchRecipesError) {
                  return Center(
                    child: Text("Erreur: ${state.message}"),
                  );
                } else if (state is FetchRecipesSuccess) {
                  if (state.recipes.isEmpty) {
                    return const Center(
                      child: Text('aucune recette trouvée'),
                    );
                  } else {
                    return _buildPendingRecipesResult(state.recipes);
                  }
                } else {
                  return const Center(
                    child: CustomLoadingIncicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingRecipesResult(List<RecipeModel> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return Dismissible(
          secondaryBackground: _selectedTab == 2
              ? null
              : Container(
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
          direction: _selectedTab == 2
              ? DismissDirection.startToEnd
              : DismissDirection.horizontal,
          onDismissed: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              await context.read<RecipeActionCubit>().performRecipeAction(
                  action: 'delete', recipeId: recipes[index].id);
            } else if (direction == DismissDirection.endToStart &&
                _selectedTab != 2) {
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
