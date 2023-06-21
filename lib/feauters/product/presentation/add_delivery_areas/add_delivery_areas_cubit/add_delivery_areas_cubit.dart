import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/product/domin/add_product/request/add_delivery_areas_request.dart';
import 'package:merchant_app/feauters/product/domin/add_product/request/add_production_request.dart';
import 'package:merchant_app/feauters/product/domin/add_product/response/add_delivery_areas_response.dart';
import 'package:merchant_app/feauters/product/presentation/add_delivery_areas/add_delivery_areas_cubit/add_delivery_areas_states.dart';

import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../../../core/resources/constants_manager.dart';

class AddDeliveryAreasCubit extends Cubit<AddDeliveryAreasStates> {
  AddDeliveryAreasCubit() : super(AddDeliveryAreasInitState());

  static AddDeliveryAreasCubit get(context) => BlocProvider.of(context);

  late AddDeliveryAreasResponse addDeliveryAreasResponse;

  addDeliveryAreas(
      {required AddDeliveryAreasRequest addDeliveryAreasRequest,
      required String id}) {

    DioHelper.postData(
      url: Urls.addDeliveryAreasToProduct + id.toString(),
      data: addDeliveryAreasRequest.toJson(),
      token: Constants.bearer + Constants.token,
    ).then((value) {
      print('Add Here:');
      print(value.data['status']);
      addDeliveryAreasResponse = AddDeliveryAreasResponse.fromJson(value.data);
      emit(AddDeliveryAreasDoneState(addDeliveryAreasResponse));
    }).catchError((error) {
      print(error.toString());
      emit(AddDeliveryAreasErrorState(error.toString()));
    });
  }
}
