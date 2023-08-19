
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../domin/add_product/response/get_categories_response.dart';
import '../../../domin/product_details/product_models/products_list_model.dart';



part 'merchant_layout_states.dart';

class MerchantLayoutCubit extends Cubit<MerchantLayoutStates> {
  MerchantLayoutCubit() : super(MerchantLayoutInitialState());

  static MerchantLayoutCubit get(context) => BlocProvider.of(context);

  // 1- Get Merchant Products:
  ProductsListModel? merchantProductsModel = ProductsListModel();
  List<Product> products = [];

  getMerchantProducts({
    required String merchantId,
  }) {
    emit(GetMerchantProLoadingState());
    if (products.isNotEmpty) {
      emit(GetMerchantProDoneState(products: products));
    } else {
      DioHelper.getData(
        url: Urls.getMerchantProducts + merchantId,
      ).then((value) {
        merchantProductsModel = ProductsListModel.fromJson(value.data);
        if (merchantProductsModel?.data?.products != null) {
          if (merchantProductsModel!.data!.products.isNotEmpty) {
            products = merchantProductsModel!.data!.products;
            emit(GetMerchantProDoneState(products: products));
          }
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetMerchantProErrorState());
      });
    }
  }

  // Get Merchant Categories
  GetCategoriesResponse? categoriesModel = GetCategoriesResponse();
  List<CategoryData> categories = [];

  getMerchantCategories({
    required String merchantId,
  }) {
    emit(GetMerchantCategoriesLoadingState());
    if (categories.isNotEmpty) {
      emit(GetMerchantCategoriesDoneState());
    } else {
      DioHelper.getData(
        url: Urls.getCategories,
        query: {'owner': merchantId},
      ).then((value) {
        categoriesModel = GetCategoriesResponse.fromJson(value.data);
        if (value.data['status']) {
          if (categoriesModel?.data != null &&
              categoriesModel!.data!.isNotEmpty) {
            categories = categoriesModel!.data!;
            emit(GetMerchantCategoriesDoneState());
          }
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetMerchantCategoriesLoadingState());
      });
    }
  }

  // 3. Get Merchant Products By Category:

  ProductsListModel? merchantProductsByCatModel = ProductsListModel();
  List<Product> productsOfCat = [];

  getProductsByCategory({
    required String catName,
    required String? merchantId,
  }) {
    emit(GetMerchantProsByCatLoadingState());

    if (productsOfCat.isNotEmpty) {
      emit(GetMerchantProsByCatDoneState());
    } else {
      DioHelper.getData(
        url: Urls.getMerchantProsByCat + catName,
        query: {
          "owner": merchantId,
        },
      ).then((value) {
        merchantProductsByCatModel = ProductsListModel.fromJson(value.data);
        if (value.data['status'] &&
            merchantProductsByCatModel?.data?.products != null) {
          if (merchantProductsByCatModel!.data!.products.isNotEmpty) {
            productsOfCat = merchantProductsByCatModel!.data!.products;
            emit(GetMerchantProsByCatDoneState());
          }
        }
      }).catchError((err) {
        print(err.toString());
        emit(GetMerchantProsByCatErrorState());
      });
    }
  }
}
