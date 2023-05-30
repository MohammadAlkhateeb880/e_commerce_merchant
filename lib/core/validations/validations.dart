import '../../feauters/product/domin/add_product/response/get_categories_response.dart';

class Validations{
 static bool isEmailValid(String email) {
    return RegExp(
        r'^[\w.%+-]+@\w+\.\w{2,}(?:\s)$')
        .hasMatch(email);
  }

 static bool isPasswordValid(String password) {
    return RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }


 static  bool isWriteInEnglishValid(String password) {
    return RegExp(
        r'^[a-zA-Z0-9_@.\s-]+$')
        .hasMatch(password);
  }

 static bool isWriteInArabicValid(String password) {
    return RegExp(
        r'^[\u0600-\u06FF0-9_@.\s-]+$')
        .hasMatch(password);
  }




}