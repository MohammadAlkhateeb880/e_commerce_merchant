part of 'add_vr_product_cubit.dart';

@immutable
abstract class AddVRProductStates {}

class AddVRProductInitialState extends AddVRProductStates {}

class AddVRProductLoadingState extends AddVRProductStates {}

class AddVRProductDoneState extends AddVRProductStates {
  final AddVRProductResponse addVRProductResponse;

  AddVRProductDoneState(this.addVRProductResponse);

}

class AddVRProductErrorState extends AddVRProductStates {
  final error;

  AddVRProductErrorState(this.error);
}
