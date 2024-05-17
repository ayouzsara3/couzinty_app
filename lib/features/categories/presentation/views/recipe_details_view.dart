import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/functions/arrays_equal.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/features/categories/data/repos/category_repo_impl.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RecipeDetailsView extends StatefulWidget {
  const RecipeDetailsView({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  State<RecipeDetailsView> createState() => _RecipeDetailsViewState();
}

class _RecipeDetailsViewState extends State<RecipeDetailsView> {
  late bool isFav;
  late bool isList;
  late String userId;
  late String userRole;
  bool isFavorite() {
    return context.read<UserCubit>().state.favorites.contains(widget.recipe.id);
  }

  bool isInShoppingList() {
    final shoppingList = context.read<UserCubit>().state.shoppingList;
    final recipeIngredient = widget.recipe.ingredients;
    return arraysEqual(shoppingList!, recipeIngredient);
  }

  onClickShoppingList() async {
    final isEmptyShoppingList =
        context.read<UserCubit>().state.shoppingList!.isEmpty;

    try {
      if (isEmptyShoppingList) {
        await getIt<CategoryRepoImpl>()
            .shoppingListAction('add', widget.recipe.ingredients, userId);

        context
            .read<UserCubit>()
            .updateUser(shoppingList: widget.recipe.ingredients);
        setState(() {
          isList = !isList;
        });
      } else if (!isEmptyShoppingList && !isList) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: 'Voulez-vous effacer la liste précédente ?',
          confirmBtnText: 'effacer',
          cancelBtnText: 'annuler',
          title: 'Es-tu sûr?',
          textColor: kDarkBlue,
          cancelBtnTextStyle:
              AppStyles.styleBold17(context).copyWith(color: kDarkBlue),
          headerBackgroundColor: kMainGreen,
          confirmBtnColor: kMainGreen,
          onConfirmBtnTap: () async {
            await getIt<CategoryRepoImpl>()
                .shoppingListAction('add', widget.recipe.ingredients, userId);

            context
                .read<UserCubit>()
                .updateUser(shoppingList: widget.recipe.ingredients);

            setState(() {
              isList = !isList;
            });

            Navigator.of(context).pop();
          },
        );
      } else {
        await getIt<CategoryRepoImpl>()
            .shoppingListAction('remove', widget.recipe.ingredients, userId);

        context.read<UserCubit>().updateUser(shoppingList: []);

        setState(() {
          isList = !isList;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  onClickFavorite() async {
    try {
      if (!isFav) {
        await getIt<CategoryRepoImpl>()
            .favoriteRecipeAction('add', widget.recipe.id, userId);
      } else {
        await getIt<CategoryRepoImpl>()
            .favoriteRecipeAction('remove', widget.recipe.id, userId);
      }

      if (!context.mounted) {
        return;
      }
      context.read<UserCubit>().updateUser(recipeId: widget.recipe.id);

      setState(() {
        isFav = !isFav;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    isFav = isFavorite();
    isList = isInShoppingList();
    userId = context.read<UserCubit>().state.id;
    userRole = context.read<UserCubit>().state.role;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Hero(
              tag: widget.recipe.id,
              child: CachedNetworkImage(
                imageUrl: widget.recipe.image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          buttons(context),
          scroll(),
        ],
      ),
    ));
  }

  buttons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          userRole == 'user'
              ? InkWell(
                  onTap: () async {
                    await onClickShoppingList();
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: Tween(begin: 0.0, end: 1.0)
                                  .animate(animation),
                              child: child,
                            );
                          },
                          child: Icon(
                            Icons.shopping_cart,
                            size: 20,
                            color: !isList ? Colors.white : kMainGreen,
                            key: ValueKey(isList),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(width: 16),
          userRole == 'user'
              ? InkWell(
                  onTap: () async {
                    onClickFavorite();
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: Tween(begin: 0.0, end: 1.0)
                                  .animate(animation),
                              child: child,
                            );
                          },
                          child: Icon(
                            CupertinoIcons.heart_fill,
                            size: 20,
                            color: !isFav ? Colors.white : kMainGreen,
                            key: ValueKey(isFav),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 1.0,
        minChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Text(widget.recipe.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.styleBold22(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.recipe.category,
                        style: AppStyles.styleMedium17(context),
                      ),
                      const Spacer(),
                      RatingBarIndicator(
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: kMainGreen,
                          );
                        },
                        itemSize: 24,
                        itemCount: 5,
                        rating: widget.recipe.rate,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text("Informations",
                      style: AppStyles.styleBold17(context)
                          .copyWith(fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.people_alt_outlined,
                              color: kMainGreen,
                              size: 30,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.recipe.personsNumber == 1
                                  ? '${widget.recipe.personsNumber} Personne'
                                  : '${widget.recipe.personsNumber} Personnes',
                              style: AppStyles.styleBold15(context),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: kMainGreen,
                              size: 30,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${widget.recipe.cookingTime} Minutes',
                              style: AppStyles.styleBold15(context),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.speed_rounded,
                              color: kMainGreen,
                              size: 30,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.recipe.difficulty,
                              style: AppStyles.styleBold15(context),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Ingredients",
                    style:
                        AppStyles.styleBold17(context).copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.recipe.ingredients.length,
                    itemBuilder: (context, index) =>
                        ingredients(context, widget.recipe.ingredients[index]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Instructions",
                    style:
                        AppStyles.styleBold17(context).copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.recipe.instructions.length,
                    itemBuilder: (context, index) => steps(
                        context, index, widget.recipe.instructions[index]),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ingredients(BuildContext context, String ingredient) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xFFE3FFF8),
            child: Icon(
              Icons.done,
              size: 15,
              color: kMainGreen,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            ingredient,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  steps(BuildContext context, int index, String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: kMainGreen,
            radius: 12,
            child: Text(
              "${index + 1}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 270,
                child: Text(
                  step,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: kDarkBlue),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
