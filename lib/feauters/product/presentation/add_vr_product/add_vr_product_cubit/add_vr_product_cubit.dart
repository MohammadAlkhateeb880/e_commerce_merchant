import 'package:bloc/bloc.dart';
import 'package:merchant_app/core/config/urls.dart';
import 'package:merchant_app/core/data/network/remote/dio_helper.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../domin/add_product/response/add_vr_product_rersponse.dart';
import 'dart:typed_data';

part 'add_vr_product_state.dart';

class AddVRProductCubit extends Cubit<AddVRProductStates> {
  AddVRProductCubit() : super(AddVRProductInitialState());

  static AddVRProductCubit get(context) => BlocProvider.of(context);

  late AddProductResponse addVRProductResponse = AddProductResponse();

  addVRProduct({required String? fileVRPath, required String id}) async {
//==================================
//     Uint8List fileBytes = await File(fileVRPath!).readAsBytes();
//
//     // Create a FormData object with the file as a part
//     FormData formData = FormData.fromMap({
//       'file': MultipartFile.fromBytes(fileBytes,),
//     });
//===================================
    FormData formData = FormData.fromMap({
      'vrImage': await MultipartFile.fromFile(
        fileVRPath!,
        filename: 'vrImage',
      ),
    });
//=====================================

    // final file = await MultipartFile.fromFile(fileVRPath!);
    // final formData = FormData.fromMap({'file': file});
emit(AddVRProductLoadingState());
    DioHelper.postData(
      url: Urls.addVRImageProduct + id.toString(),
      data: formData,
      token: "Bearer " +
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM5NjY1OTE2YTcxNzMyZjY3ZGMyNGQiLCJyb2xlIjoxLCJpYXQiOjE2ODE0ODMzNTN9.JWfyyVsU8fakHV49r3qN5LyFhKwsi5Gzc3rRtDdukj4",
    ).then((value) {
      print(value.data['status']);
      addVRProductResponse = AddProductResponse.fromJson(value.data);
      emit(AddVRProductDoneState(addVRProductResponse));
    }).catchError((error) {
      print(error.toString());
      emit(AddVRProductErrorState(error));
    });
  }
}
