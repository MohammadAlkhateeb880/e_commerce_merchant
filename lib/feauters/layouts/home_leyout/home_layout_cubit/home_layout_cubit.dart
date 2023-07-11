import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/home/presentation/home_screen.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_screen.dart';
import 'package:merchant_app/feauters/profile/profile_screen.dart';

import '../../../../core/components/toast_notifications.dart';
import '../../../../core/config/urls.dart';
import '../../../../core/data/network/local/cache_helper.dart';
import '../../../../core/data/network/remote/dio_helper.dart';
import '../../../../core/network/local/keys.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../domin/response/profile_response.dart';

part 'home_layout_states.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;




  List<Widget> bottomScreens = [
    const ProfileScreen(),
    const AddProductScreen(),
    const HomeScreen(),
  ];
  List<AppBar> appBarScreens = [
    AppBar(
      title: const Text('Profile'),
    ),
    AppBar(
      title: const Text('Add Product'),
    ),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    const BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Product'),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
  ];
  List<String> titles = [
    'profile',
    'add product',
    'home',
  ];

  void changeBottom(int index, {Function? function}) {
    if (function != null) {
      function(index);
    }
    currentIndex = index;
    emit(ChangeBottomNavState(index: currentIndex));
  }

  //Get Profile
  ProfileResponse profileResponse = ProfileResponse();

  getProfile() {
    emit(GetProfileLoadingState());
    DioHelper.getData(
      url: Urls.getProfile,
      token: Constants.bearer + Constants.token,
      //token: Constants.bearer + Constants.token,
    ).then((value) {
      profileResponse = ProfileResponse.fromJson(value.data);
      if (value.data['status']) {
        CacheHelper.saveData(
          key: CacheHelperKeys.fullName,
          value: profileResponse.data?.user?.fullName,
        );
        CacheHelper.saveData(
          key: CacheHelperKeys.email,
          value: profileResponse.data?.user?.email,
        );
      }
      emit(GetProfileDoneState(profileResponse));
    }).catchError((err) {
      print(err.toString());
      emit(GetProfileErrorState());
    });
  }

  // LogOut
  logout() {
    emit(LogoutLoadingState());
    DioHelper.getData(
      url: Urls.logout,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        emit(LogoutDoneState(message: value.data['message']));
      } else if (value.data['error'] == "The provided token is invalid") {
        showToast(text: value.data['error'], state: ToastStates.ERROR);
      }
    }).catchError((err) {
      print(err.toString());
      emit(LogoutErrorState());
    });
  }

  //add To Hot Selling
  addToHotSelling({
    required String productId,
    required String endDateOfHotSelling,
  }) {
    DioHelper.postData(
            url: Urls.addToHotSelling + productId.toString(),
            token: Constants.bearer + Constants.token,
            data: {'ToHomeTrend': true, 'endDate': endDateOfHotSelling})
        .then((value) {
      emit(AddToHotSellingDoneState(message: value.data['message']!));
    }).catchError((error) {
      print(error.toString());
      emit(AddToHotSellingErrorState(message: error));
    });
  }
}
