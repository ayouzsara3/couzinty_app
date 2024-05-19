import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/categories/presentation/views/recipe_details_view.dart';
import 'package:couzinty/features/home/presentation/suggestion_recipes_cubit/fetch_slider_recipes_cubit/fetch_slider_recipes_cubit.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCustomSlider extends StatelessWidget {
  const HomeCustomSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSliderRecipesCubit, FetchSliderRecipesState>(
        builder: (context, state) {
      if (state is FetchSliderRecipesError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is FetchSliderRecipesSuccess) {
        if (state.recipes.isEmpty) {
          return const Center(
            child: Text('aucune recette trouvée'),
          );
        } else {
          return buildSlider(context, state.recipes);
        }
      } else {
        return const Center(child: CustomLoadingIncicator());
      }
    });
  }

  Widget buildSlider(context, List<RecipeModel> recipes) {
    return CarouselSlider(
        items: recipes.map((recipe) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecipeDetailsView(recipe: recipe)));
            },
            child: Container(
              width: SizeConfig.screenHeight,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  child: Hero(
                    tag: recipe.id,
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(height: 200, autoPlay: true));
  }
}
