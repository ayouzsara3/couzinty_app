import 'package:couzinty/core/utils/widgets/build_recipes_list_view.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/categories/data/models/category_model.dart';
import 'package:couzinty/features/categories/presentation/viewmodel/fetch_recipes_by_category_cubit/fetch_recipes_by_category_cubit.dart';
import 'package:couzinty/features/categories/presentation/viewmodel/fetch_recipes_by_category_cubit/fetch_recipes_by_category_state.dart';
import 'package:couzinty/features/categories/presentation/views/widgets/recipe_card.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key, required this.category});

  final Category category;

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body:
          BlocBuilder<FetchRecipesByCategoryCubit, FetchRecipesByCategoryState>(
              builder: (context, state) {
        if (state is FetchRecipesByCategoryError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is FetchRecipesByCategorySuccess) {
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
      }),
    );
  }
}
