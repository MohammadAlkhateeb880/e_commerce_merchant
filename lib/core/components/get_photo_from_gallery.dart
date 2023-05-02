import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File> takePhoto() async {
  final myFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 500.0,
      maxWidth: 500.0);
  return File(myFile!.path);
}