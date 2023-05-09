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

  late AddVRProductResponse addVRProductResponse = AddVRProductResponse();

  addVRProduct({required String? fileVRPath, required String id}) async {
//==================================
    Uint8List fileBytes = await File(fileVRPath!).readAsBytes();

    // Create a FormData object with the file as a part
    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(fileBytes,),
    });
//===================================
//     FormData formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile(
//           fileVRPath!,
//           filename: 'VRImage'),
//     });
//=====================================


    // final file = await MultipartFile.fromFile(fileVRPath!);
    // final formData = FormData.fromMap({'file': file});

    DioHelper.postData(
      url: Urls.addVrImageProduct + id.toString(),
      data: formData,
      // contentType: 'multipart/form-data; boundary=${formData.boundary}',
      token: "Bearer " +
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDMxNzBjOTFkMzI1NmM5YzdhYjA1NDAiLCJyb2xlIjoyLCJpYXQiOjE2ODA5NjE3Mzd9.ZQ0S6vT_wHH0w0kspiaHz0c4AT9_SaJlj3WkJ2cFc3g",
    ).then((value) {
      print(value.data['status']);
      addVRProductResponse = AddVRProductResponse.fromJson(value.data);
      emit(AddVRProductDoneState(addVRProductResponse));
    }).catchError((error) {
      print(error.toString());
      emit(AddVRProductErrorState(error));
    });
  }
}
