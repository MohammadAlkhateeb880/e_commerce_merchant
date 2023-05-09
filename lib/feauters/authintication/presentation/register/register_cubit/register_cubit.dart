import 'package:merchant_app/core/config/urls.dart';
import 'package:merchant_app/feauters/authintication/domin/request/regester_request.dart';
import 'package:merchant_app/feauters/authintication/domin/response/register_response.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/data/network/remote/dio_helper.dart';
import '../../../domin/response/mail_verification_respons.dart';
import 'package:dio/dio.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInit());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterResponse registerResponse = RegisterResponse();

  register({required RegisterRequest registerRequest}) async {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: Urls.register,
        data: FormData.fromMap(
          await registerRequest.toJson(
            marketLogo: registerRequest.marketLogo!,
            businessLicence: registerRequest.businesslicense!,
          ),
        )).then((value) {
      if (value.data['status']) {
        print("++++++++++++++++++++++++++++++++++++");
        registerResponse = RegisterResponse.fromJson(value.data);
        emit(RegisterDoneState(registerResponse));
      }
    }).catchError((err) {
      print(err.toString());
      emit(RegisterErrorState(err.toString()));
    });
  }

//********************* sendCode2email ****************************

  MailVerificationResponse mailVerificationResponse =
      MailVerificationResponse();

  sendCode2email({required String email}) async {
    emit(MailVerificationLoadingState());
    DioHelper.postData(url: Urls.mailVerify, data: {"email": email})
        .then((value) {
      if (value.data['status']) {
        mailVerificationResponse =
            MailVerificationResponse.fromJson(value.data);
        emit(MailVerificationDoneState(
            mailVerificationResponse: mailVerificationResponse));
      }
    }).catchError((error) {
      print(error.toString());
      emit(MailVerificationErrorState(error));
    });
  }
}
