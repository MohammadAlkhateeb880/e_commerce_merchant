import 'package:merchant_app/feauters/product/domin/add_product/request/add_offer_to_product_request.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../domin/add_product/response/add_offer_to_product_response.dart';

part 'add_offer_to_product_state.dart';

class AddOfferToProductCubit extends Cubit<AddOfferToProductStates> {
  AddOfferToProductCubit() : super(AddOfferToProductInitState());

  static AddOfferToProductCubit get(context) => BlocProvider.of(context);
  late AddOfferToProductsResponse addOfferToProductsResponse;

  addOfferToProduct({required AddOfferToProductsRequest addOfferToProductsRequest}) {
    emit(AddOfferToProductLoadingState());
    DioHelper.postData(
      url: Urls.addOfferProduct,
      data: addOfferToProductsRequest.toJson(),
      token: "Bearer " +
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM5NjY1OTE2YTcxNzMyZjY3ZGMyNGQiLCJyb2xlIjoxLCJpYXQiOjE2ODE0ODMzNTN9.JWfyyVsU8fakHV49r3qN5LyFhKwsi5Gzc3rRtDdukj4",
    ).then((value) {
      addOfferToProductsResponse=AddOfferToProductsResponse.fromJson(value.data);
      emit(AddOfferToProductDoneState());
    }).catchError((error) {
      print(error.toString());
      emit(AddOfferToProductErrorState(error));
    });
  }
}
