import 'dart:io';

import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
  });

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    // final pickedImage = await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    //   imageQuality: 50,
    //   maxHeight: 150,
    // );

    // if (pickedImage == null) {
    //   return;
    // }

    // setState(() {
    //   _pickedImageFile = File(pickedImage.path);
    // });

    // widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: const BoxDecoration(
        color: kMainGreen,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        image: DecorationImage(
          image: NetworkImage("https://via.placeholder.com/120x120"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
