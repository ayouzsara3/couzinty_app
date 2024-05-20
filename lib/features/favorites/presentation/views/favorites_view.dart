import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/features/favorites/presentation/viewmodel/fetch_favorite_recipes_cubit/fetch_favorite_recipes_cubit.dart';
import 'package:couzinty/features/favorites/presentation/views/widgets/favorites_list_view.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late List<String> recipesIds;

  @override
  void initState() {
    super.initState();
    recipesIds = context.read<UserCubit>().state.favorites;
    context.read<FetchFavoriteRecipesCubit>().fetchFavoriteRecips(recipesIds);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Favorites',
                  textAlign: TextAlign.start,
                  style: AppStyles.styleBold22(context).copyWith(
                    color: Colors.black87,
                    fontSize: 24,
                  ),
                ),
              ),
              const Expanded(
                child: FavoritesListView(),
              ),
            ])));
  }
}
