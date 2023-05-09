import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class AddCategoryRequest {
  Uint8List? imageOfCate;
  String? arName;
  String? enName;

  AddCategoryRequest({
    this.imageOfCate,
    this.enName,
    this.arName,
  });

  AddCategoryRequest.fromJson(Map<String, dynamic> json) {
    imageOfCate = json['ImageOfCate'];
    arName = json['arName'];
    enName = json['enName'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ImageOfCate'] = MultipartFile.fromBytes(imageOfCate ?? [0]);
    data['arName'] = arName;
    data['enName'] = enName;
    return data;
  }
}
