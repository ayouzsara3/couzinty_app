import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';

class UploadCustomTextFormField extends StatefulWidget {
  UploadCustomTextFormField({
    super.key,
    this.maxLines = 1,
    this.icon,
    required this.hint,
    this.radius = 10,
    required this.onSave,
  });
  int maxLines;
  IconData? icon;
  String hint;
  double radius;

  final Function onSave;

  @override
  State<UploadCustomTextFormField> createState() =>
      _UploadCustomTextFormFieldState();
}

class _UploadCustomTextFormFieldState extends State<UploadCustomTextFormField> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Ce champ est obligatoire';
          }
          return null;
        },
        controller: textController,
        maxLines: widget.maxLines,
        onSaved: (value) {
          widget.onSave(value);
        },
        decoration: InputDecoration(
          icon: widget.icon == null ? null : Icon(widget.icon),
          hintText: widget.hint,
          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: kLightBlue),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(color: kLightBlue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(color: kLightBlue)),
        ));
  }
}
