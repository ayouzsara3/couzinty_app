import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuggestRecipeCard extends StatelessWidget {
  const SuggestRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 101,
          decoration: ShapeDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/burger.jpg"),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pancake',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.styleBold17(context).copyWith(color: kDeepBlue),
        ),
        Row(
          children: [
            const FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                Icons.watch_later_outlined,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '60 Min',
              style: AppStyles.styleMedium15(context),
            )
          ],
        )
      ],
    );
  }
}
