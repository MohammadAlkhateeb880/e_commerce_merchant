import 'package:merchant_app/feauters/product/domin/add_product/response/add_image_response.dart';

abstract class AddImageProductStates {}

class AddImageProductInitState extends AddImageProductStates {}

class AddImageProductDoneState extends AddImageProductStates{
  final AddImageProductResponse addImageProductResponse;

  AddImageProductDoneState(this.addImageProductResponse);
}

class AddImageProductLoadingState extends AddImageProductStates{}

class AddImageProductErrorState extends AddImageProductStates{
  final  err;

  AddImageProductErrorState(this.err);
}
