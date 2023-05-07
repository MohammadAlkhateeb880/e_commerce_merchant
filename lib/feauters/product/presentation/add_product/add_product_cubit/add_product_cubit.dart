import 'package:merchant_app/core/config/urls.dart';
import 'package:merchant_app/core/data/network/remote/dio_helper.dart';
import 'package:merchant_app/feauters/product/domin/add_product/response/get_categories_response.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domin/add_product/request/add_production_request.dart';
import '../../../domin/add_product/response/add_production_response.dart';

class AddProductionCubit extends Cubit<AddProductionStates> {
  AddProductionCubit() : super(AddProductionInitState());

  static AddProductionCubit get(context) => BlocProvider.of(context);

  late AddProductionResponse addProductResponse;

  addProduction({required AddProductionRequest addProductRequest}) {
    emit(AddProductionLoadingState());
    DioHelper.postData(
      url: Urls.addProduction,
      token:'Bearer '+'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM5NjY1OTE2YTcxNzMyZjY3ZGMyNGQiLCJyb2xlIjoxLCJpYXQiOjE2ODE0ODMzNTN9.JWfyyVsU8fakHV49r3qN5LyFhKwsi5Gzc3rRtDdukj4',
      data: addProductRequest.toJson(),
    ).then((value) {
      addProductResponse = AddProductionResponse.fromJson(value.data);
      emit(AddProductionDoneState(addProductResponse));
    }).catchError((error) {
      print(error.toString());
      emit(AddProductionErrorState(error.toString()));
    });
  }

  GetCategoriesResponse? getCategoriesResponse = GetCategoriesResponse();
  List<CategoryData> categories = [];

  getMerchantCategories({
    required String merchantId,
  }) {
    emit(GetCategoriesLoadingState());
    print("HEEEEEEEEEER");
    DioHelper.getData(
      url: Urls.getCategories,
      query: {'owner': merchantId},
    ).then((value) {
      print("VAAAAAAAAAAAAAAAAAAAAAAL");
      getCategoriesResponse = GetCategoriesResponse.fromJson(value.data);
      categories = getCategoriesResponse!.data!;
      emit(GetCategoriesDoneState());
    }).catchError((err) {
      print(err.toString());
      emit(GetCategoriesLoadingState());
    });
  }
}
