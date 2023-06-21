import 'package:merchant_app/feauters/product/domin/add_product/request/add_offer_to_product_request.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../../../core/resources/constants_manager.dart';
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
      token:  Constants.bearer + Constants.token,
    ).then((value) {
      if(value.data['status']){
        addOfferToProductsResponse=AddOfferToProductsResponse.fromJson(value.data);
        emit(AddOfferToProductDoneState());
      }else{
        print(value.data['message']!);
        emit(AddOfferToProductErrorState(value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(AddOfferToProductErrorState(error));
    });
  }
}
