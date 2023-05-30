class Urls {
  static const String baseUrl = 'http://192.168.216.175:3000/user/';

  //static const String baseUrl = 'http://192.168.1.104:3000/user/';

  static const String filesUrl = 'http://192.168.1.104:3000/api/download?fileName';

  //authentication
  static const String register = '${baseUrl}Merchant/SignUp';
  static const String mailVerify = '${baseUrl}sendCodeToEmail';
  static const String login = '${baseUrl}Merchant/auth';
  static const String logout = '${baseUrl}allUsers/logout';
  //product management
  static const String addProduction = '${baseUrl}Merchant/addProduct';
  static const String addImageProduct = '${baseUrl}Merchant/addImagesProduct/';
  static const String addDeliveryAreasToProduct =
      '${baseUrl}Merchant/addDeliveryAreasToProduct/';
  static const String addVideoProduct = '${baseUrl}Merchant/addVideoProduct/';
  static const String addVRImageProduct = '${baseUrl}Merchant/addVrImageProduct/';
  static const String addARImageProduct = '${baseUrl}Merchant/addArImageProduct/';
  static const String addOfferProduct = '${baseUrl}Merchant/addOffer';
  static const String addCategories = '${baseUrl}Merchant/addingCategorie';
  static const String addToHotSelling = '${baseUrl}Merchant/addToHotSelling/';
  //get api
  static const String getCategories = '${baseUrl}allUsers/getCategorie/';
  static const String getProfile = '${baseUrl}Merchant/getProfile';
  static const String getMerchantProducts = '${baseUrl}allUsers/MerchantProducts/';
  //advanced Search
  static const String advancedSearch = '${baseUrl}allUsers/SearchProduct';

}
