part of 'home_layout_cubit.dart';

@immutable
abstract class HomeLayoutStates {}

class HomeInitialState extends HomeLayoutStates {}

class ChangeBottomNavState extends HomeLayoutStates {
  final int index;

  ChangeBottomNavState({required this.index});
}

// Get Profile
class GetProfileLoadingState extends HomeLayoutStates {}

class GetProfileDoneState extends HomeLayoutStates {
  final ProfileResponse profileResponse;

  GetProfileDoneState(this.profileResponse);
}

class GetProfileLocallyDoneState extends HomeLayoutStates {
  final String? fullName;
  final String? email;

  GetProfileLocallyDoneState({
    this.fullName,
    this.email,
  });
}

class GetProfileErrorState extends HomeLayoutStates {}


//Logout States

class LogoutLoadingState extends HomeLayoutStates {}

class LogoutDoneState extends HomeLayoutStates {
  final String message;

  LogoutDoneState({required this.message});
}

class LogoutErrorState extends HomeLayoutStates {}

// add To Hot Selling States
class AddToHotSellingLoadingState extends HomeLayoutStates {}

class AddToHotSellingDoneState extends HomeLayoutStates {
  final String message;

  AddToHotSellingDoneState({required this.message});
}

class AddToHotSellingErrorState extends HomeLayoutStates {
  final String message;

  AddToHotSellingErrorState({required this.message});
}



