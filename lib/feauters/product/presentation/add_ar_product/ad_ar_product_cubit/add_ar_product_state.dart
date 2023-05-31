part of 'add_ar_product_cubit.dart';

@immutable
abstract class AddARProductStates {}

class AddARProductInitialState extends AddARProductStates {}
class AddARProductLoadingState extends AddARProductStates {}

class AddARProductDoneState extends AddARProductStates {
  final AddProductResponse addARProductResponse;

  AddARProductDoneState(this.addARProductResponse);

}

class AddARProductErrorState extends AddARProductStates {
  final error;

  AddARProductErrorState(this.error);
}