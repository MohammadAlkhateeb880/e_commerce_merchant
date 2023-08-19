part of 'update_product_cubit.dart';

@immutable
abstract class UpdateProductState {}

class UpdateProductInfoInitialState extends UpdateProductState {}
class UpdateProductInfoLoadingState extends UpdateProductState {}
class UpdateProductInfoDoneState extends UpdateProductState {}
class UpdateProductInfoErrorState extends UpdateProductState {}


