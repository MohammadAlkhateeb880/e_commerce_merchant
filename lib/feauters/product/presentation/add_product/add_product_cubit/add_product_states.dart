
import '../../../domin/add_product/response/add_production_Response.dart';

abstract class AddProductionStates {}

class AddProductionInitState extends AddProductionStates {}

class AddProductionLoadingState extends AddProductionStates {}

class AddProductionDoneState extends AddProductionStates {
  final AddProductionResponse addProductResponse;

  AddProductionDoneState(this.addProductResponse);
}

class AddProductionErrorState extends AddProductionStates {
  final err;

  AddProductionErrorState(this.err);
}
