import 'package:merchant_app/core/config/urls.dart';
import 'package:merchant_app/core/data/network/remote/dio_helper.dart';
import 'package:merchant_app/core/network/local/cache_helper.dart';
import 'package:merchant_app/core/network/local/keys.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
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
    print('Token ============> ');
    print('Token ============> ${Constants.token} ');
    emit(AddProductionLoadingState());
    DioHelper.postData(
      url: Urls.addProduction,
      token: Constants.bearer + Constants.token,
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
  List<String?> arCategories = [];
  List<String?> enCategories = [];

  getMerchantCategories({
    required String merchantId,
  }) {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(
      url: Urls.getCategories,
      query: {'owner': merchantId},
    ).then((value) {
      getCategoriesResponse = GetCategoriesResponse.fromJson(value.data);
      categories = getCategoriesResponse!.data!;
      arCategories = categories.map((category) => category.arName).toList();
      arCategories.insert(0, "NO Selected");
      enCategories = categories.map((category) => category.enName).toList();
      enCategories.insert(0, "NO Selected");

      emit(GetCategoriesDoneState(data: categories));
    }).catchError((err) {
      print(err.toString());
      emit(GetCategoriesLoadingState());
    });
  }
}
