part of 'add_offer_to_product_cubit.dart';

@immutable
abstract class AddOfferToProductStates {}

class AddOfferToProductInitState extends AddOfferToProductStates {}
class AddOfferToProductLoadingState extends AddOfferToProductStates {}
class AddOfferToProductDoneState extends AddOfferToProductStates {

}
class AddOfferToProductErrorState extends AddOfferToProductStates {
  final String err;

  AddOfferToProductErrorState(this.err);

}
