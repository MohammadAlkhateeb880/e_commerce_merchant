import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/order/domin/response/single_order_response.dart';
import 'package:meta/meta.dart';

import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../domin/response/get_orders_response.dart';

part 'orders_states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);

  GetOrdersResponse getOrdersResponse = GetOrdersResponse();
  List<OrderData> orders = [];

  getUserOrders({String? merchant_id}) {
    emit(GetOrdersLoadingState());

    DioHelper.getData(
      query: {
        'merchant_id': merchant_id,
      },
      url: Urls.getMerchantProducts,
      token:"Bearer " +"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDc2MTY5MmU2ZDVlYTdhMThkNzFiYzEiLCJyb2xlIjoyLCJpYXQiOjE2ODU0NjExODZ9.ogPWoeOTrOokm8CeW5nP-93NNyxXFtJilCLfhaespGA" ,
    ).then((value) {
      if (value.data['status']) {
        getOrdersResponse = GetOrdersResponse.fromJson(value.data);
        if (getOrdersResponse.data != null) {
          orders = getOrdersResponse.data!;
        }
        emit(GetOrdersDoneState(getOrdersResponse));
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetOrdersErrorState(err));
    });
  }

// 3. Get Single Order By ID:
  SingleOrderResponse singleOrderResponse = SingleOrderResponse();

  getOrderById({
    required String orderId,
  }) {
    emit(GetSingleOrderByIdLoadingState());
    DioHelper.getData(
      url: Urls.getOrderById + orderId,
      token:"Bearer " +"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDc2MTY5MmU2ZDVlYTdhMThkNzFiYzEiLCJyb2xlIjoyLCJpYXQiOjE2ODU0NjExODZ9.ogPWoeOTrOokm8CeW5nP-93NNyxXFtJilCLfhaespGA" ,
    ).then((value) {
      if (value.data['status']) {
        singleOrderResponse = SingleOrderResponse.fromJson(value.data);
        emit(GetSingleOrderByIdDoneState());
      }
    }).catchError((err) {
      print(err.toString());
      emit(GetSingleOrderByIdErrorState());
    });
  }
}
