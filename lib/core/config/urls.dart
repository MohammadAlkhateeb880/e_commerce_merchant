class Urls {
  //static const String baseUrl = 'http://192.168.56.176:3000/user/';

  static const String baseUrl = 'http://192.168.1.107:3000/user/';

  static const String register = '${baseUrl}Merchant/SignUp';
  static const String mailVerify = '${baseUrl}sendCodeToEmail';
  static const String login = '${baseUrl}Merchant/auth';
  static const String addProduction = '${baseUrl}Merchant/addProduct';
  static const String addImageProduct = '${baseUrl}Merchant/addImagesProduct/';
  static const String addDeliveryAreasToProduct =
      '${baseUrl}Merchant/addDeliveryAreasToProduct/';
  static const String addVrImageProduct =
      '${baseUrl}Merchant/addVrImageProduct/';
  static const String addOfferProduct = '${baseUrl}Merchant/addOffer';
  static const String getCategories = '${baseUrl}allUsers/getCategorie/';
  static const String addCategories = '${baseUrl}Merchant/addingCategorie';
}
