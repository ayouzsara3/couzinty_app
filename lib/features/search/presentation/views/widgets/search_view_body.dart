import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/categories/presentation/views/widgets/recipe_card.dart';
import 'package:couzinty/features/home/presentation/suggestion_recipes_cubit/cubit/suggestion_recipes_cubit.dart';
import 'package:couzinty/features/home/presentation/views/widgets/custom_text_form_field.dart';
import 'package:couzinty/features/search/presentation/viewmodel/cubit/search_cubit.dart';
import 'package:couzinty/features/search/presentation/views/widgets/custom_filter.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  TextEditingController searchController = TextEditingController();
  bool isSearchByIngredient = false;

  String? selectedCategory;
  double? selectedCookingTime;
  String? selectedDifficulty;

  void setFilter(category, cookingTime, difficulty) {
    selectedCategory = category;
    selectedCookingTime = cookingTime;
    selectedDifficulty = difficulty;

    print(
        'category1: $category , cookingTime1: $cookingTime , difficult1: $difficulty');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: kMainGreen,
                          )),
                      Expanded(
                        child: Column(
                          children: [
                            CustomTextFormField(
                              hint: "Recherche",
                              prefixIcon: Icons.search,
                              controller: searchController,
                              filled: true,
                              suffixIcon: searchController.text.isEmpty
                                  ? null
                                  : Icons.cancel_sharp,
                              onTapSuffixIcon: () {
                                searchController.clear();
                                context.read<SearchCubit>().search(
                                      searchController.text,
                                      isSearchByIngredient,
                                      category: selectedCategory,
                                      cookingTime: selectedCookingTime,
                                      difficulty: selectedDifficulty,
                                    );
                              },
                              onChanged: (query) {
                                setState(() {
                                  context.read<SearchCubit>().search(
                                        searchController.text,
                                        isSearchByIngredient,
                                        category: selectedCategory,
                                        cookingTime: selectedCookingTime,
                                        difficulty: selectedDifficulty,
                                      );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  context: context,
                                  builder: (context) => CustomFilter(
                                        onChoosenFilter: setFilter,
                                      ));
                            });
                          },
                          icon: const Icon(
                            Icons.filter_alt_rounded,
                            color: kMainGreen,
                            size: 26,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isSearchByIngredient,
                          onChanged: (value) {
                            setState(() {
                              isSearchByIngredient = value!;
                              if (searchController.text.isNotEmpty) {
                                context.read<SearchCubit>().search(
                                      searchController.text,
                                      isSearchByIngredient,
                                      category: selectedCategory,
                                      cookingTime: selectedCookingTime,
                                      difficulty: selectedDifficulty,
                                    );
                              }
                            });
                          },
                          activeColor: kMainGreen,
                        ),
                        const Text(
                          'Ingredients',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CustomLoadingIncicator(),
                    );
                  } else if (state is SearchSuccess) {
                    if (state.recipes.isEmpty ||
                        searchController.text.isEmpty) {
                      return const Center(
                        child: Text('aucune recette trouvée'),
                      );
                    } else {
                      context
                          .read<SuggestionRecipesCubit>()
                          .setSearchResults(state.recipes);
                      return _buildSearchResults(state.recipes);
                    }
                  } else if (state is SearchError) {
                    return Center(
                      child: Text("Erreur: ${state.message}"),
                    );
                  } else {
                    return const Center(
                      child: Text('Commencez à chercher des recettes'),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildSearchResults(List<RecipeModel> recipes) {
  return ListView.builder(
    itemCount: recipes.length,
    itemBuilder: (context, index) {
      return RecipeCard(
        recipe: recipes[index],
      );
    },
  );
}
