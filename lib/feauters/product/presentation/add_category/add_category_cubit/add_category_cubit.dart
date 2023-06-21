import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/data/network/local/cache_helper.dart';
import 'package:merchant_app/core/data/network/remote/dio_helper.dart';
import 'package:merchant_app/core/network/local/keys.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
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

    print(formData.fields);
    print(formData.files);

    emit(AddCategoryInitState());
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
}
