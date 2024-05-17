import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signin_cubit/signin_cubit.dart';
import 'package:couzinty/features/recipes_review/data/repos/recipes_review_repo_impl.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/fetch_recipes/fetch_recipes_cubit.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/recipe_action_cubit/recipe_action_cubit.dart';
import 'package:couzinty/features/recipes_review/presentation/views/widgets/recipes_review_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecipesReviewView extends StatelessWidget {
  const RecipesReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchRecipesCubit>(
            create: (context) =>
                FetchRecipesCubit(getIt<RecipesReviewRepoImpl>())),
        BlocProvider<RecipeActionCubit>(
            create: (context) =>
                RecipeActionCubit(getIt<RecipesReviewRepoImpl>())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Revue de recettes'),
          actions: [
            InkWell(
              onTap: () async {
                await context.read<SigninCubit>().logout();
                GoRouter.of(context).pushReplacement(AppRouter.kSignInView);
              },
              child: const Icon(Icons.logout),
            ),
            const SizedBox(width: 10),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kUploadView);
          },
          shape: const CircleBorder(),
          backgroundColor: kMainGreen,
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: const RecipesReviewBody(),
      ),
    );
  }
}
