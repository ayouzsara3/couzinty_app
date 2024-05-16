import 'package:couzinty/core/utils/widgets/build_recipes_list_view.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/favorites/presentation/viewmodel/fetch_favorite_recipes_cubit/fetch_favorite_recipes_cubit.dart';
import 'package:couzinty/features/favorites/presentation/viewmodel/fetch_favorite_recipes_cubit/fetch_favorite_recipes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesListView extends StatelessWidget {
  const FavoritesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchFavoriteRecipesCubit, FetchFavoriteRecipesState>(
        builder: (context, state) {
      if (state is FetchFavoriteRecipesError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is FetchFavoriteRecipesSuccess) {
        if (state.recipes.isEmpty) {
          return const Center(
            child: Text('aucune recette trouvée'),
          );
        } else {
          return buildRecipesListView(state.recipes);
        }
      } else {
        return const Center(child: CustomLoadingIncicator());
      }
    });
  }
}
