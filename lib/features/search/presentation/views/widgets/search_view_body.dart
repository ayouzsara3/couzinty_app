import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/categories/presentation/views/widgets/recipe_card.dart';
import 'package:couzinty/features/home/presentation/views/widgets/custom_text_form_field.dart';
import 'package:couzinty/features/search/data/repos/search_repo_impl.dart';
import 'package:couzinty/features/search/presentation/viewmodel/cubit/search_cubit.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  TextEditingController searchController = TextEditingController();
  static List previousSearches = [];

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
              padding: const EdgeInsets.all(20),
              child: Row(
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
                    child: CustomTextFormField(
                      hint: "Recherche",
                      prefixIcon: Icons.search,
                      controller: searchController,
                      filled: true,
                      suffixIcon: searchController.text.isEmpty
                          ? null
                          : Icons.cancel_sharp,
                      onTapSuffixIcon: () {
                        searchController.clear();
                      },
                      onChanged: (query) {
                        context.read<SearchCubit>().search(query);
                      },
                      onEditingComplete: () {},
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
                      return _buildSearchResults(state.recipes);
                    }
                  } else if (state is SearchError) {
                    return Center(
                      child: Text("Erreur: ${state.message}"),
                    );
                  } else {
                    return const Center(
                      child: Text('Commencez à chercher des recettes'),
                    ); // Placeholder for initial UI
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
  // Build UI for displaying search results
  // Example:
  return ListView.builder(
    itemCount: recipes.length,
    itemBuilder: (context, index) {
      return RecipeCard(
        recipe: recipes[index],
      );
    },
  );
}
