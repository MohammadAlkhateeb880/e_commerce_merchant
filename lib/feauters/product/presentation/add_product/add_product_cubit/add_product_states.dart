
import '../../../domin/add_product/response/add_production_response.dart';
import '../../../domin/add_product/response/get_categories_response.dart';

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

class GetCategoriesLoadingState extends AddProductionStates {}

class GetCategoriesDoneState extends AddProductionStates {

  GetCategoriesDoneState();
}

class GetCategoriesErrorState extends AddProductionStates {
  final err;

  GetCategoriesErrorState(this.err);
}
