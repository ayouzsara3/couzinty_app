import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.image,
    required this.onPickImage,
  });

  final String image;
  final Function onPickImage;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    await widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    print('image url ${widget.image}');
    return SizedBox(
      width: 110,
      height: 110,
      child: InkWell(
        onTap: () async {
          _pickImage();
        },
        child: widget.image == ''
            ? CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade300,
                foregroundImage: _pickedImageFile != null
                    ? FileImage(_pickedImageFile!)
                    : null,
                child: _pickedImageFile == null
                    ? const Icon(
                        Icons.camera_alt_rounded,
                        color: kDarkBlue,
                      )
                    : null,
              )
            : CircleAvatar(
                radius: 40,
                foregroundImage: CachedNetworkImageProvider(
                  widget.image,
                )),
      ),
    );
  }
}
