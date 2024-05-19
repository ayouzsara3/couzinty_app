import 'package:couzinty/features/navigation/presentation/views/widgets/buttom_bar_item.dart';
import 'package:flutter/material.dart';

class CustomButtomBar extends StatefulWidget {
  const CustomButtomBar(
      {super.key, required this.currentTab, required this.pageController});

  final int currentTab;
  final PageController pageController;

  @override
  State<CustomButtomBar> createState() => _CustomButtomBarState();
}

class _CustomButtomBarState extends State<CustomButtomBar> {
  void navigateToPage(int index) {
    widget.pageController.jumpToPage(
      index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NavbarItem(
                index: 0,
                iconPath: 'assets/images/list.svg',
                currentTab: widget.currentTab,
                onTap: navigateToPage),
            NavbarItem(
                index: 1,
                iconPath: 'assets/images/fav.svg',
                currentTab: widget.currentTab,
                onTap: navigateToPage),
            NavbarItem(
                index: 2,
                iconPath: 'assets/images/home.svg',
                currentTab: widget.currentTab,
                onTap: navigateToPage),
            NavbarItem(
                index: 3,
                iconPath: 'assets/images/category.svg',
                currentTab: widget.currentTab,
                onTap: navigateToPage),
            NavbarItem(
                index: 4,
                iconPath: 'assets/images/profile.svg',
                currentTab: widget.currentTab,
                onTap: navigateToPage),
          ],
        ),
      ),
    );
  }
}
