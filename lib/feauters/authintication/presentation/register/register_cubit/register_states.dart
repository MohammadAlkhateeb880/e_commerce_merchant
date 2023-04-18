import 'package:merchant_app/feauters/authintication/domin/response/register_response.dart';

import '../../../domin/response/mail_verification_respons.dart';

abstract class RegisterStates {}

class RegisterInit extends RegisterStates{}


class RegisterLoadingState extends RegisterStates{}

class RegisterDoneState extends RegisterStates{
  final RegisterResponse registerResponse;

  RegisterDoneState(this.registerResponse);

}
class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);

}



// send Code To Email States

class MailVerificationLoadingState extends RegisterStates {}

class MailVerificationDoneState extends RegisterStates {
  final MailVerificationResponse? mailVerificationResponse;

  MailVerificationDoneState({this.mailVerificationResponse});
}

class MailVerificationErrorState extends RegisterStates {
  final error;

  MailVerificationErrorState(this.error);
}
