import 'dart:io';
import 'package:dio/dio.dart';

class AddImageProductRequest {
  File? mainImage;
  List<File>? gallery;

  AddImageProductRequest({this.mainImage, this.gallery});

  AddImageProductRequest.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    gallery = json['gallery'];
  }

  Future<Map<String, dynamic>> toJson({
    required File? mainImage,
    required List<File>? gallery,
  }) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainImage'] = await MultipartFile.fromFile(mainImage!.path);
    if (gallery != null) {
      data['gallery'] = await Future.wait(gallery.map((image) async {
        return await MultipartFile.fromFile(image.path);
      }));
    }
    return data;
  }
}

// ==========================================
// class AddImageProductRequest {
//   File? mainImage;
//   List<File>? gallery;
//
//   AddImageProductRequest({this.mainImage, this.gallery});
//
//   AddImageProductRequest.fromJson(Map<String, dynamic> json) {
//     mainImage = json['mainImage'];
//     gallery = json['gallery'].cast<String>();
//   }
//
//   Future<Map<String, dynamic>> toJson({
//     required File? mainImage,
//     required List<File>? gallery,
// }) async {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['mainImage'] = await MultipartFile.fromFile(mainImage!.path);
//     data['gallery'] = gallery;
//     return data;
//   }
// }
