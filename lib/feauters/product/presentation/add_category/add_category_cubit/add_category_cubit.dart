import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/data/network/local/cache_helper.dart';
import 'package:merchant_app/core/data/network/remote/dio_helper.dart';
import 'package:merchant_app/core/network/local/keys.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/feauters/product/domin/add_product/response/get_categories_response.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_cubit.dart';
import '../../../../../core/config/urls.dart';
import 'package:dio/dio.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryStates> {
  AddCategoryCubit() : super(AddCategoryInitState());

  static AddCategoryCubit get(context) => BlocProvider.of(context);

  // late AddCategoryResponse addCategoryResponse;

  addCategory({
    required String enName,
    required String arName,
    required String imageName,
    required File imageOfCate,
    required BuildContext context,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'ImageOfCate': await MultipartFile.fromFile(
          imageOfCate.path,
          filename: imageName,
        ),
        'arName': arName,
        'enName': enName,
      },
    );

    emit(AddCategoryLoadingState());
    DioHelper.postData(
      url: Urls.addCategories,
      token: Constants.bearer + CacheHelper.getData(key: CacheHelperKeys.token),
      data: formData,
    ).then((value) {
      AddProductionCubit.get(context).getMerchantCategories(
          merchantId: CacheHelper.getData(key: CacheHelperKeys.sId));
      emit(AddCategoryDoneState());
    }).catchError((error) {
      print(error.toString());
      emit(AddCategoryErrorState(error));
    });
  }

  updateCategory({
    required String catId,
    required String enName,
    required String arName,
    required String imageName,
    required File imageOfCate,
    required BuildContext context,
  }) async {
    emit(UpdateCategoryLoadingState());
    FormData formData = FormData.fromMap(
      {
        'ImageOfCate': await MultipartFile.fromFile(
          imageOfCate.path,
          filename: imageName,
        ),
        'arName': arName,
        'enName': enName,
      },
    );

    DioHelper.postData(
      url: Urls.updateCategories + catId,
      token: Constants.bearer + CacheHelper.getData(key: CacheHelperKeys.token),
      data: formData,
    ).then((value) async {
      await AddProductionCubit.get(context)
          .getMerchantCategories(merchantId: Constants.sId);
      emit(UpdateCategoryDoneState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateCategoryErrorState(error));
    });
  }

  // Delete Category:

  deleteCategory({
    required String catId,
    required BuildContext context,
  }) {
    emit(DeleteCategoryLoadingState());
    DioHelper.deleteData(
      url: Urls.deleteCategories + catId,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      AddProductionCubit.get(context)
          .getMerchantCategories(merchantId: Constants.sId);
      emit(DeleteCategoryDoneState());
    }).catchError((err) {
      print(err.toString());
      emit(DeleteCategoryErrorState(err));
    });
  }
}
