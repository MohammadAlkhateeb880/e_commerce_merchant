import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/urls.dart';
import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../order/domin/response/single_order_response.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInfoInitialState());

  static UpdateProductCubit get(context) => BlocProvider.of(context);

  updateProductInfo({
  required String nameProduct,
  required String discriptionProduct,
  required String mineCategoriesProduct,
  required String manifacturingMaterialProduct,
  required int guaranteeProduct,
  required String proId
  }){
    emit(UpdateProductInfoInitialState());
    DioHelper.postData(
      url: Urls.updateProductInfo + proId,
      data: {
        "name":nameProduct,
        "Guarantee":guaranteeProduct,
        "descreption":discriptionProduct,
        "mainCategorie":mineCategoriesProduct,
        "manufacturingMaterial":manifacturingMaterialProduct
              },
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']){
        emit(UpdateProductInfoDoneState());
      }else{
        emit(UpdateProductInfoErrorState());
      }
    }).catchError((error){
      emit(UpdateProductInfoErrorState());
    });
  }

  updateClassInfo({
    required int priceProduct,
    required int widthProduct,
    required int lengthProduct,
    required String sizeProduct,
    required String classId
  }){
    emit(UpdateProductInfoInitialState());
    DioHelper.postData(
      url: Urls.updateClaccInfo + classId,
      data: {
        "price":priceProduct,
        "width":widthProduct,
        "length":lengthProduct,
        "size":sizeProduct,
      },
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']){
        emit(UpdateProductInfoDoneState());
      }else{
        emit(UpdateProductInfoErrorState());
      }
    }).catchError((error){
      print("*************************");
      print(error.toString());
      emit(UpdateProductInfoErrorState());
    });
  }


}
