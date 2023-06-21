part of 'orders_cubit.dart';

@immutable
abstract class OrdersStates {}

class OrdersInitialState extends OrdersStates {}

class GetOrdersLoadingState extends OrdersStates {}

class GetOrdersDoneState extends OrdersStates {
  final GetOrdersResponse getOrdersResponse;

  GetOrdersDoneState(this.getOrdersResponse);
}

class GetOrdersErrorState extends OrdersStates {
  final error;

  GetOrdersErrorState(this.error);
}

// Get Single Order By ID States:

class GetSingleOrderByIdLoadingState extends OrdersStates {}

class GetSingleOrderByIdDoneState extends OrdersStates {}

class GetSingleOrderByIdErrorState extends OrdersStates {}

// Change Order State States:

class ChangeOrderStatusLoadingState extends OrdersStates {}

class ChangeOrderStatusDoneState extends OrdersStates {}

class ChangeOrderStatusErrorState extends OrdersStates {}

