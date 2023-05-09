import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UploadFilePage extends StatefulWidget {
  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  List<File> _files = [];

  Future<void> _getFiles() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      _files = pickedFiles.map((file) => File(file.path)).toList();
    });
  }

  Future<void> _uploadFiles() async {
    final url = 'http://192.168.1.107:3000/upload';
    final formData = FormData();

    for (var i = 0; i < _files.length; i++) {
      final file = _files[i];
      formData.files.add(MapEntry(
        'file$i',
        await MultipartFile.fromFile(
          file.path,
         // filename: file.path.split('/').last,
        ),
      ));
    }

    try {
      final response = await Dio().post(url, data: formData);
      print('Files uploaded successfully');
    } catch (e) {
      print('Error uploading files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Files')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_files.isNotEmpty) ...[
              for (var file in _files) Image.file(file, height: 200),
              SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: _getFiles,
              child: Text('Select Files'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFiles,
              child: Text('Upload Files'),
            ),
          ],
        ),
      ),
    );
  }
}
