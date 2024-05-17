import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/core/utils/widgets/custom_loading_indicator.dart';
import 'package:couzinty/features/categories/data/repos/category_repo_impl.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:couzinty/features/shopping_list/presentation/viewmodel/cubit/shopping_list_cubit.dart';
import 'package:couzinty/features/shopping_list/presentation/viewmodel/cubit/shopping_list_state.dart';
import 'package:couzinty/features/shopping_list/presentation/views/widgets/ingredient_card.dart';
import 'package:couzinty/features/shopping_list/presentation/views/widgets/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  late List<String> ingredients;
  late String userId;

  List<List<dynamic>> ingredientsList = [];

  @override
  void initState() {
    super.initState();
    userId = context.read<UserCubit>().state.id;
    context.read<ShoppingListCubit>().fetchShoppingList(userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Liste de courses',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleBold22(context).copyWith(
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      ingredients =
                          context.read<UserCubit>().state.shoppingList!;
                      if (ingredients.isNotEmpty) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Voulez-vous effacer la liste ?',
                          confirmBtnText: 'effacer',
                          cancelBtnText: 'annuler',
                          title: 'Es-tu sûr?',
                          textColor: kDarkBlue,
                          cancelBtnTextStyle: AppStyles.styleBold17(context)
                              .copyWith(color: kDarkBlue),
                          headerBackgroundColor: kMainGreen,
                          confirmBtnColor: kMainGreen,
                          onConfirmBtnTap: () async {
                            await getIt<CategoryRepoImpl>()
                                .shoppingListAction('remove', [], userId);

                            context.read<UserCubit>().state.shoppingList = [];

                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 26,
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: BlocBuilder<ShoppingListCubit, ShoppingListState>(
                builder: (context, state) {
              if (state is ShoppingListError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is ShoppingListLoaded) {
                if (state.shoppingList.isEmpty) {
                  return const Center(
                    child: Text('Aucune recette trouvée'),
                  );
                } else {
                  ingredientsList = state.shoppingList
                      .map((ingredient) => [ingredient, false])
                      .toList();
                  return ShoppingList(
                    shoppingList: ingredientsList,
                  );
                }
              } else {
                return const Center(child: CustomLoadingIncicator());
              }
            })),
          ],
        ),
      ),
    );
  }
}
