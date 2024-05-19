import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/data/categories.dart';
import 'package:flutter/material.dart';

class CustomCategoriesList extends StatefulWidget {
  const CustomCategoriesList({super.key, required this.onSave});

  final Function onSave;

  @override
  State<CustomCategoriesList> createState() => _CustomCategoriesListState();
}

class _CustomCategoriesListState extends State<CustomCategoriesList> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: menuButton(
                  onTap: () {
                    setState(() {
                      _index = index;
                      widget.onSave(categories[index].name);
                    });
                  },
                  isSelected: _index == index ? true : false,
                  text: categories[index].name,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget menuButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        // height: 100,
        decoration: BoxDecoration(
          color: isSelected ? kMainGreen : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: !isSelected
              ? Border.all(
                  color: kLightBlue,
                  width: 1,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: isSelected ? Colors.white : kLightBlue),
          ),
        ),
      ),
    );
  }
}
