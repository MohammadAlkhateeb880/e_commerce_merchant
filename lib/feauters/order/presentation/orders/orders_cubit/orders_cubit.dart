import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/order/domin/response/single_order_response.dart';
import 'package:meta/meta.dart';

import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../../../core/resources/constants_manager.dart';
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
      url: Urls.getOrdersForMerchantProducts,
      token: Constants.bearer +Constants.token,
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
      token: Constants.bearer+Constants.token,
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

  SingleOrderResponse changStatusOrderResponse = SingleOrderResponse();

  changeOrderStates({required String orderId, required String status}) {
    emit(ChangeOrderStatusLoadingState());
    DioHelper.putData(
            url: Urls.changeOrderStatus,
            data: {"id": orderId, "status": status},
            token: Constants.bearer+Constants.token,
    )
        .then((value) {
      if (value.data['status']) {
        changStatusOrderResponse = SingleOrderResponse.fromJson(value.data);
        emit(ChangeOrderStatusDoneState());
      }
    }).catchError((error) {
      print(error);
      emit(ChangeOrderStatusErrorState());
    });
  }
}
