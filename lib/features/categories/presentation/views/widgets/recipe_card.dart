import 'package:cached_network_image/cached_network_image.dart';
import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/categories/presentation/views/recipe_details_view.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => RecipeDetailsView(
                  recipe: recipe,
                ))));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                    tag: recipe.name,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: recipe.image,
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.styleBold17(context)
                          .copyWith(color: kDeepBlue),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star,
                              color: kMainGreen,
                            );
                          },
                          itemSize: 16,
                          itemCount: 5,
                          rating: recipe.rate,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color:
                                _buildDifficultyBackground(recipe.difficulty),
                          ),
                          child: Text(
                            recipe.difficulty,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.styleMedium15(context)
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _buildDifficultyBackground(String difficulty) {
    switch (difficulty) {
      case 'Moyen':
        return Colors.orangeAccent;
      case 'Facile':
        return Colors.greenAccent;
      case 'Difficile':
        return Colors.redAccent;
      default:
        return Colors.greenAccent;
    }
  }
}
