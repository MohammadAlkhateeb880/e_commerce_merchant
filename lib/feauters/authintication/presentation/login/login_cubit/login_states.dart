import 'package:merchant_app/feauters/authintication/domin/response/login_response.dart';

abstract class LoginStates{}

class LoginInitState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginDoneState extends LoginStates{
  final LoginResponse loginResponse;

  LoginDoneState(this.loginResponse);
}
class LoginErrorState extends LoginStates{
  final err;

  LoginErrorState(this.err);
}