import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/data/network/remote/dio_helper.dart';
import 'package:merchant_app/feauters/product/domin/add_category/response/add_category_response.dart';
import '../../../../../core/config/urls.dart';
import '../../../domin/add_category/request/add_category_request.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryStates> {
  AddCategoryCubit() : super(AddCategoryInitState());

  static AddCategoryCubit get(context) => BlocProvider.of(context);

  // late AddCategoryResponse addCategoryResponse;

  // addCategory({
  //   required String enName,
  //   required String arName,
  //   required String imageName,
  //   required File imageOfCate,
  // }) async {
  //   FormData formData = FormData.fromMap(
  //     {
  //       'ImageOfCate': await MultipartFile.fromFile(
  //         imageOfCate.path,
  //         filename: "Categorie/$imageName"
  //       ),
  //       'arName': arName,
  //       'enName': enName,
  //     },
  //   );
  //
  //   print(formData.fields);
  //   print(formData.files);
  //
  //   emit(AddCategoryInitState());
  //   DioHelper.postData(
  //     url: Urls.addCategories,
  //     token: "Bearer " +
  //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM5NWQ2NzUxMTk3NTVhMjczMWZiZjIiLCJyb2xlIjoyLCJpYXQiOjE2ODE0ODEwNjR9.NCEkWpgNEOP-3_VONCmWXf7TIky0MCpkED1m6UrmSHc",
  //     data: formData,
  //   ).then((value) {
  //     emit(AddCategoryDoneState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AddCategoryErrorState(error));
  //   });
  // }

addCategory({
  required String enName,
  required String arName,
  required String imageName,
  required File imageOfCate,
}) async {
  var headers = {
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM5NWQ2NzUxMTk3NTVhMjczMWZiZjIiLCJyb2xlIjoyLCJpYXQiOjE2ODE0ODEwNjR9.NCEkWpgNEOP-3_VONCmWXf7TIky0MCpkED1m6UrmSHc'
  };
  var request = http.MultipartRequest('POST', Uri.parse(Urls.addCategories));
  request.fields.addAll({
    'arName': arName,
    'enName': enName,
  });
  request.files.add(await http.MultipartFile.fromPath('ImageOfCate',imageOfCate.path));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}

/*





* */
}
