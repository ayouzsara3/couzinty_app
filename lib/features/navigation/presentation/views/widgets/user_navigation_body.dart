import 'package:couzinty/features/auth/presentation/views/favorites/presentation/views/favorites_view.dart';
import 'package:couzinty/features/categories/presentation/views/categories_view.dart';
import 'package:couzinty/features/home/presentation/views/home_view.dart';
import 'package:couzinty/features/navigation/presentation/views/widgets/custom_buttom_bar.dart';
import 'package:couzinty/features/profile/presentation/views/profile_view.dart';
import 'package:couzinty/features/shopping_list/presentation/views/shopping_list_view.dart';

import 'package:flutter/material.dart';

class UserNavigatioBody extends StatefulWidget {
  const UserNavigatioBody({super.key});

  @override
  State<UserNavigatioBody> createState() => _UserNavigatioBodyState();
}

class _UserNavigatioBodyState extends State<UserNavigatioBody> {
  int currentTab = 2;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentTab);
  }

  final List<Widget> screens = [
    const CategoriesView(),
    const ShoppingListView(),
    const HomeView(),
    const FavoritesView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CustomButtomBar(
        pageController: pageController,
        currentTab: currentTab,
      ),
    );
  }
}
