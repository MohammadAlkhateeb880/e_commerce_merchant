import 'dart:io';

import 'package:dio/dio.dart';

import 'package:merchant_app/feauters/product/domin/add_product/request/add_image_request.dart';
import 'package:merchant_app/feauters/product/presentation/add_image_product/add_image_product_cubit/add_image_product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../domin/add_product/response/add_image_response.dart';

class AddImageProductCubit extends Cubit<AddImageProductStates> {
  AddImageProductCubit() : super(AddImageProductInitState());

  static AddImageProductCubit get(context) => BlocProvider.of(context);

  AddImageProductResponse addImageProductResponse = AddImageProductResponse();

  addImageProduct({
    required AddImageProductRequest addImageProductRequest,
    required String id,
  }) async {
    try {
      List<MultipartFile> multipartFiles = [];
      if (addImageProductRequest.gallery != null) {
        for (File file in addImageProductRequest.gallery!) {
          if (file.existsSync()) {
            multipartFiles.add(
              await MultipartFile.fromFile(
                file.path,
              //  filename: 'gallery',
              ),
            );
          }
        }
      }

      if (addImageProductRequest.mainImage != null &&
          addImageProductRequest.mainImage!.existsSync()) {
        FormData formData = FormData.fromMap({
          'mainImage': await MultipartFile.fromFile(
              addImageProductRequest.mainImage!.path,
             // filename: 'mainImage',
          ),
          'gallery': multipartFiles,
        });
        print("======================= Main image path: ");
        print(addImageProductRequest.mainImage!.path);
        print("======================= Gallery images paths: ");
        print(addImageProductRequest.gallery!.first.path);

        var response = await DioHelper.postData(
          url: Urls.addImageProduct + id.toString(),
          data: formData,
          //contentType: "multipart/form-data",
          token: "Bearer " +
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDMxNzBjOTFkMzI1NmM5YzdhYjA1NDAiLCJyb2xlIjoyLCJpYXQiOjE2ODA5NjE3Mzd9.ZQ0S6vT_wHH0w0kspiaHz0c4AT9_SaJlj3WkJ2cFc3g",
        );

        if (response.data['status'] == true) {
          addImageProductResponse =
              AddImageProductResponse.fromJson(response.data);
          emit(AddImageProductDoneState(addImageProductResponse));
        } else {
          emit(AddImageProductErrorState(response.data['message']));
        }
      } else {
        emit(AddImageProductErrorState("Main image not found"));
      }
    } catch (error) {
      print(error.toString());
      emit(AddImageProductErrorState(error.toString()));
    }
  }
}