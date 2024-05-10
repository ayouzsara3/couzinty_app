import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/size_config.dart';
import 'package:couzinty/features/home/presentation/views/widgets/custom_text_form_field.dart';
import 'package:couzinty/features/home/presentation/views/widgets/home_custom_slider.dart';
import 'package:couzinty/features/home/presentation/views/widgets/custom_grid.dart';
import 'package:couzinty/features/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: Text('Bienvenue Sara 👋',
                          textAlign: TextAlign.start,
                          style: AppStyles.styleBold22(context)
                              .copyWith(color: Colors.black87)),
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
      ),
    );
  }
}
