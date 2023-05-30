import 'package:file_picker/file_picker.dart';
Future<String?> pickXFile() async {
  final result = await FilePicker.platform.pickFiles();

  if (result != null) {
    // The user picked a file.
    final file = result.files.first;
    print(file.name);
    print(file.bytes);
    print(file.extension);
    print(file.path);
    print(file.size);
    return file.path;
    // Do something with the file, e.g. read its contents.
  } else {
    // The user canceled the picker.
    return null;
  }
}