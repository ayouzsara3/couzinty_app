import 'dart:io';

import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key, required this.onPickImage});

  final Function onPickImage;

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File? _selectedImage;

  void takaPicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 600, maxHeight: 300);
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: takaPicture,
      child: DottedBorder(
          dashPattern: const [15, 5],
          color: kLightBlue,
          strokeWidth: 2,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          child: _selectedImage == null
              ? SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.photo,
                          size: 65,
                          color: kLightBlue,
                        ),
                        Text(
                          "Ajouter une photo",
                          style: AppStyles.styleBold15(context),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    height: 160,
                    width: double.infinity,
                  ),
                )),
    );
  }
}
