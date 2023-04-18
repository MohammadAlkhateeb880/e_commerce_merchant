import 'package:merchant_app/feauters/authintication/domin/request/login_request.dart';

import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../domin/response/login_response.dart';
import 'login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/config/urls.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);
 late LoginResponse loginResponse;

  login({required LoginRequest loginRequest}) {
    emit(LoginInitState());
    DioHelper.postData(
        url: Urls.login,
        data: loginRequest.toJson())
        .then((value) {
      loginResponse = LoginResponse.fromJson(value.data);
      emit(LoginDoneState(loginResponse));
    }).catchError((err) {
      print(err.toString());
      emit(LoginErrorState(err));
    });
  }
}
