part of 'add_video_product_cubit.dart';

@immutable
abstract class AddVideoProductStates {}

class AddVideoProductInitialState extends AddVideoProductStates {}
class AddVideoProductLoadingState extends AddVideoProductStates {}

class AddVideoProductDoneState extends AddVideoProductStates {
  final AddProductResponse addVideoProductResponse;

  AddVideoProductDoneState(this.addVideoProductResponse);

}

class AddVideoProductErrorState extends AddVideoProductStates {
  final error;

  AddVideoProductErrorState(this.error);
}
