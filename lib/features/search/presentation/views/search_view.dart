import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/home/presentation/views/widgets/custom_text_form_field.dart';
import 'package:couzinty/features/navigation/presentation/views/user_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Search Bar
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: kMainGreen,
                        )),
                    Expanded(
                      child: CustomTextFormField(
                        hint: "Recherche",
                        prefixIcon: Icons.search,
                        controller: searchController,
                        filled: true,
                        suffixIcon: searchController.text.isEmpty
                            ? null
                            : Icons.cancel_sharp,
                        onTapSuffixIcon: () {
                          searchController.clear();
                        },
                        onChanged: (pure) {
                          setState(() {});
                        },
                        onEditingComplete: () {
                          // previousSearchs.add(searchController.text);
                          GoRouter.of(context).push(AppRouter.kUserNavigation);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
