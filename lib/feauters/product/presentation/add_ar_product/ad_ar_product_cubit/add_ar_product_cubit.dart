import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../domin/add_product/response/add_vr_product_rersponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_ar_product_state.dart';

class AddARProductCubit extends Cubit<AddARProductStates> {
  AddARProductCubit() : super(AddARProductInitialState());


  static AddARProductCubit get(context) => BlocProvider.of(context);

  late AddProductResponse addVRProductResponse = AddProductResponse();

  addARProduct({required String? fileARPath, required String id}) async {
    emit(AddARProductInitialState());
    FormData formData = FormData.fromMap({
      'arImage': await MultipartFile.fromFile(
        fileARPath!,
        filename: 'arImage',
      ),
    });

    emit(AddARProductLoadingState());
    DioHelper.postData(
      url: Urls.addARProduct + id.toString(),
      data: formData,
      token:  Constants.bearer + Constants.token,
    ).then((value) {
      print(value.data['status']);
      addVRProductResponse = AddProductResponse.fromJson(value.data);
      emit(AddARProductDoneState(addVRProductResponse));
    }).catchError((error) {
      print(error.toString());
      emit(AddARProductErrorState(error));
    });
  }
}
