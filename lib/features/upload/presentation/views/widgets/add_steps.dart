import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/upload_custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddSteps extends StatefulWidget {
  const AddSteps({super.key});

  @override
  State<AddSteps> createState() => _AddStepsState();
}

class _AddStepsState extends State<AddSteps> {
  List steps = [1];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Steps",
                style: AppStyles.styleBold22(context),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      steps.add(step(1));
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: kDeepBlue,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: steps.length,
            itemBuilder: (context, index) => step(index),
          ),
        ],
      ),
    );
  }

  step(int index) {
    return Dismissible(
      direction: steps.length > 1
          ? DismissDirection.endToStart
          : DismissDirection.none,
      key: GlobalKey(),
      onDismissed: (d) {
        setState(() {
          steps.removeAt(index);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            UploadCustomTextFormField(
              hint: "Tell a little about your food",
              icon: Icons.drag_indicator,
              maxLines: 4,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: kMainGreen,
                radius: 12,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
