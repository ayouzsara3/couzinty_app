import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/categories/presentation/views/recipe_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => const RecipeDetailsView(
                  image: 'assets/images/burger.jpg',
                ))));
      },
      child: AspectRatio(
        aspectRatio: 6.5 / 2,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                    tag: 15, child: Image.asset('assets/images/burger.jpg')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pancake',
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
                            '60 Min',
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
                            rating: 4.5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.orangeAccent,
                            ),
                            child: Text(
                              'Medium',
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
      ),
    );
  }
}
