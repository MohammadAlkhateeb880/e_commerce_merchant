class Urls {
  static const String baseUrl = 'http://192.168.1.107:3000/user/';
  //static const String baseUrl = 'http://192.168.98.175:3000/user/';


  static const String register = '${baseUrl}Merchant/SignUp';
  static const String mailVerify = '${baseUrl}sendCodeToEmail';
  static const String login = '${baseUrl}Merchant/auth';
  static const String addProduction = '${baseUrl}Merchant/addProduct';
  static const String addImageProduct = '${baseUrl}Merchant/addImagesProduct/';
  static const String addDeliveryAreasToProduct = '${baseUrl}Merchant/addDeliveryAreasToProduct/';
  static const String addVrImageProduct = '${baseUrl}Merchant/addVrImageProduct/';
}




