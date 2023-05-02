import 'package:merchant_app/feauters/product/domin/add_product/response/add_delivery_areas_response.dart';

abstract class AddDeliveryAreasStates{}

class AddDeliveryAreasInitState extends AddDeliveryAreasStates{}

class AddDeliveryAreasDoneState extends AddDeliveryAreasStates{
  final AddDeliveryAreasResponse addDeliveryAreasResponse;

  AddDeliveryAreasDoneState(this.addDeliveryAreasResponse);
}

class AddDeliveryAreasLoadingState extends AddDeliveryAreasStates{}

class AddDeliveryAreasErrorState extends AddDeliveryAreasStates{
  final err;

  AddDeliveryAreasErrorState(this.err);

}