import 'package:merchant_app/core/config/urls.dart';
import 'package:merchant_app/core/data/network/remote/dio_helper.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domin/add_product/request/add_production_request.dart';
import '../../../domin/add_product/response/add_production_Response.dart';

class AddProductionCubit extends Cubit<AddProductionStates> {
  AddProductionCubit() : super(AddProductionInitState());

  static AddProductionCubit get(context) => BlocProvider.of(context);

  late AddProductionResponse addProductResponse;

  addProduction({required AddProductionRequest addProductRequest}) {
    emit(AddProductionLoadingState());
    DioHelper.postData(
      url: Urls.addProduction,
      data: addProductRequest.toJson(),
    ).then((value) {
      addProductResponse = AddProductionResponse.fromJson(value.data);
      emit(AddProductionDoneState(addProductResponse));
    }).catchError((error) {
      print(error.toString());
      emit(AddProductionErrorState(error.toString()));
    });
  }
}
