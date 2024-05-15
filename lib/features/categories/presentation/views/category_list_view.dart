import 'package:couzinty/features/categories/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return null;

            // return const RecipeCard(recipe: ,);
          },
        ),
      ),
    );
  }
}
