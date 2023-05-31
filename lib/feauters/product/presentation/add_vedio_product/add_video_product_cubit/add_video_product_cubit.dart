import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../domin/add_product/response/add_vr_product_rersponse.dart';
import 'package:dio/dio.dart';
part 'add_video_product_state.dart';

class AddVideoProductCubit extends Cubit<AddVideoProductStates> {
  AddVideoProductCubit() : super(AddVideoProductInitialState());

  static AddVideoProductCubit get(context) => BlocProvider.of(context);
  late AddProductResponse addVideoProductResponse = AddProductResponse();

  addVideoProduct({required String? fileVideoPath, required String id}) async {
//==================================
//     Uint8List fileBytes = await File(fileVRPath!).readAsBytes();
//
//     // Create a FormData object with the file as a part
//     FormData formData = FormData.fromMap({
//       'file': MultipartFile.fromBytes(fileBytes,),
//     });
//===================================
    FormData formData = FormData.fromMap({
      'mainVideo': await MultipartFile.fromFile(
        fileVideoPath!,
        filename: 'mainVideo',
      ),
    });
//=====================================

    // final file = await MultipartFile.fromFile(fileVRPath!);
    // final formData = FormData.fromMap({'file': file});
emit(AddVideoProductLoadingState());
    DioHelper.postData(
      url: Urls.addVideoProduct + id.toString(),
      data: formData,
      token: "Bearer " +
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM5NjY1OTE2YTcxNzMyZjY3ZGMyNGQiLCJyb2xlIjoxLCJpYXQiOjE2ODE0ODMzNTN9.JWfyyVsU8fakHV49r3qN5LyFhKwsi5Gzc3rRtDdukj4",
    ).then((value) {
      print(value.data['status']);
      addVideoProductResponse = AddProductResponse.fromJson(value.data);
      emit(AddVideoProductDoneState(addVideoProductResponse));
    }).catchError((error) {
      print(error.toString());
      emit(AddVideoProductErrorState(error));
    });
  }
}
