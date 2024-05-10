import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/categories/presentation/views/categories_view.dart';
import 'package:couzinty/features/favorites/presentation/views/favorites_view.dart';
import 'package:couzinty/features/home/presentation/views/home_view.dart';
import 'package:couzinty/features/navigation/presentation/views/widgets/custom_app_bar.dart';
import 'package:couzinty/features/navigation/presentation/views/widgets/custom_buttom_bar.dart';
import 'package:couzinty/features/profile/presentation/views/profile_view.dart';
import 'package:couzinty/features/shopping_list/presentation/views/shopping_list_view.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    const ShoppingListView(),
    const FavoritesView(),
    const HomeView(),
    const CategoriesView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentTab = index;
          });
        },
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
      bottomNavigationBar: CustomButtomBar(
        pageController: pageController,
        currentTab: currentTab,
      ),
    );
  }
}
