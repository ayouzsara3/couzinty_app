import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/upload_custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddSteps extends StatefulWidget {
  const AddSteps({super.key, required this.onSave});

  final Function onSave;

  @override
  State<AddSteps> createState() => _AddStepsState();
}

class _AddStepsState extends State<AddSteps> {
  List stepsWidgets = [1];

  List<String> steps = [];

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
                "Instructions",
                style: AppStyles.styleBold17(context),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      stepsWidgets.add(step(1));
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
            itemCount: stepsWidgets.length,
            itemBuilder: (context, index) => step(index),
          ),
        ],
      ),
    );
  }

  step(int index) {
    return Dismissible(
      direction: stepsWidgets.length > 1
          ? DismissDirection.endToStart
          : DismissDirection.none,
      key: GlobalKey(),
      onDismissed: (direction) {
        setState(() {
          stepsWidgets.removeAt(index);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            UploadCustomTextFormField(
              hint: "Parlez un peu de votre recette",
              icon: Icons.drag_indicator,
              maxLines: 4,
              onSave: (value) {
                steps.add(value);
                widget.onSave(steps);
              },
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
