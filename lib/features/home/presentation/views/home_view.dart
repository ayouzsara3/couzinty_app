import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:couzinty/features/home/presentation/viewmodel/fetch_slider_recipes_cubit/fetch_slider_recipes_cubit.dart';
import 'package:couzinty/features/home/presentation/viewmodel/suggestion_recipes/suggestion_recipes_cubit.dart';
import 'package:couzinty/features/home/presentation/viewmodel/suggestion_recipes/suggestion_recipes_state.dart';
import 'package:couzinty/features/home/presentation/views/widgets/custom_text_form_field.dart';
import 'package:couzinty/features/home/presentation/views/widgets/home_custom_slider.dart';
import 'package:couzinty/features/home/presentation/views/widgets/custom_grid.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:couzinty/features/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<FetchSliderRecipesCubit>().fetchSliderRecipes();
    final suggestionRecipesCubit = context.read<SuggestionRecipesCubit>();

    // Check if searchResults are empty
    if (suggestionRecipesCubit.state is! SuggestionRecipesSuccess) {
      suggestionRecipesCubit.fetchRandomRecipes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.read<UserCubit>().state.userName;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    'assets/images/home_background.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Bienvenue $userName 👋',
                        textAlign: TextAlign.start,
                        style: AppStyles.styleBold22(context)
                            .copyWith(color: Colors.black87),
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize! * 3),
                    const HomeCustomSlider(),
                    SizedBox(height: SizeConfig.defaultSize! * 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()),
                          );
                        },
                        child: CustomTextFormField(
                          hint: "Trouver une recette",
                          prefixIcon: Icons.search,
                          filled: true,
                          enabled: false,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize! * 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Suggestions',
                            style: AppStyles.styleBold17(context).copyWith(
                                color: const Color.fromARGB(174, 0, 0, 0)),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Voir tout',
                              style: AppStyles.styleMedium15(context)
                                  .copyWith(color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize! * 2),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomGrid(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
