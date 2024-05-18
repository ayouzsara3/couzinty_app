import 'package:cached_network_image/cached_network_image.dart';
import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/categories/presentation/views/recipe_details_view.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/material.dart';

class SuggestRecipeCard extends StatelessWidget {
  const SuggestRecipeCard({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailsView(recipe: recipe)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(recipe.image),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            recipe.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.styleBold17(context).copyWith(color: kDeepBlue),
          ),
          Row(
            children: [
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  Icons.watch_later_outlined,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${recipe.cookingTime} Min',
                style: AppStyles.styleMedium15(context),
              )
            ],
          )
        ],
      ),
    );
  }
}
