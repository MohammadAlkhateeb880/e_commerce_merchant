part of 'home_cubit.dart';

@immutable
abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetMerchantProLoadingState extends HomeStates {}

class GetMerchantProDoneState extends HomeStates {
  final List<Products>? products;

  GetMerchantProDoneState({this.products});
}

class GetMerchantProErrorState extends HomeStates {
  final error;

  GetMerchantProErrorState(this.error);
}

// Advanced Search States
class AdvancedSearchLoadingState extends HomeStates {}

class AdvancedSearchDoneState extends HomeStates {
 final AdvancedSearchResponse advancedSearchResponse;
  AdvancedSearchDoneState(this.advancedSearchResponse);
}

class AdvancedSearchErrorState extends HomeStates {
  final error;

  AdvancedSearchErrorState(this.error);
}
