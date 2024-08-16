import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> uploadImage(BuildContext context) async {
  File? image;
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );
  if (pickedFile != null) {
    image = File(pickedFile.path);
  } else {}
  return image;
}
