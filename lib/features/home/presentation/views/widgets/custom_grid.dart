import 'package:couzinty/features/home/presentation/views/widgets/suggest_recipe_card.dart';
import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const SuggestRecipeCard();
      },
    );
  }
}
