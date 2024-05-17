import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/features/categories/data/repos/category_repo_impl.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:couzinty/features/shopping_list/presentation/views/widgets/ingredient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key, required this.shoppingList});

  final List<List<dynamic>> shoppingList;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  void checkBoxChanged(int index) {
    setState(() {
      widget.shoppingList[index][1] = !widget.shoppingList[index][1];
    });
  }

  void deleteTask(int index) async {
    final userId = context.read<UserCubit>().state.id;

    widget.shoppingList.removeAt(index);

    List<String> updatedShoppingList =
        widget.shoppingList.map((item) => item[0] as String).toList();

    await getIt<CategoryRepoImpl>()
        .shoppingListAction('add', updatedShoppingList, userId);

    context.read<UserCubit>().updateUser(shoppingList: updatedShoppingList);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: widget.shoppingList.length,
        itemBuilder: (context, index) {
          return IngredientCard(
            ingredientName: widget.shoppingList[index][0],
            ingredientCompleted: widget.shoppingList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
