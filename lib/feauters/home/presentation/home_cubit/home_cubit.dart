import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/urls.dart';
import '../../../../core/data/network/remote/dio_helper.dart';
import '../../domin/response/advanced_search_response.dart';
import '../../domin/request/advanced_search_request.dart';
import '../../domin/response/get_images_response.dart';
import '../../domin/response/get_merchant_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  GetMerchantResponse getMerchantResponse = GetMerchantResponse();
  List<Products> products = [];


  getMerchantProducts({
    required String merchantId,
  }) {
    emit(GetMerchantProLoadingState());

    DioHelper.getData(
      url: Urls.getMerchantProducts + merchantId,
    ).then((value) {
      getMerchantResponse = GetMerchantResponse.fromJson(value.data);
      // products=value.data['products'];
      if (getMerchantResponse.data?.products != null) {
        products = getMerchantResponse.data!.products!;
        emit(GetMerchantProDoneState(products: products));
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetMerchantProErrorState(err.toString()));
    });
  }

  AdvancedSearchResponse advancedSearchResponse = AdvancedSearchResponse();

  advancedSearch({
    required String ownerId,
    required AdvancedSearchRequest advancedSearchRequest,
    int page = 1,
  }) {
    emit(AdvancedSearchLoadingState());
    DioHelper.postData(
            query: {
          'page': page.toString(),
          'owner': ownerId,
        },
            url: Urls.advancedSearch,
            token: 'Bearer ' +
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDYyM2FmOGQ1MGY2ZjMwM2QxYWVlZmUiLCJyb2xlIjoyLCJpYXQiOjE2ODQyMzMyNDB9.AVljABOh_rsZg0MTPfCu14qWHxq6vVt7QBqNTkRWzec',
            data: advancedSearchRequest.toJson())
        .then((value) {
      if (value.data['status']) {
        advancedSearchResponse =
            AdvancedSearchResponse.fromJson(value.data['data']);

        emit(AdvancedSearchDoneState(advancedSearchResponse));
      }
    }).catchError((error) {
      print(error.toString());
      emit(AdvancedSearchErrorState(error.toString()));
    });
  }
}
