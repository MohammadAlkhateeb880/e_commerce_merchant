class   Urls {
  static const String baseUrl = '$ip/user/';
  static const String ip = 'http://192.168.1.114:3000';
  static const String filesUrl = '$ip/api/download?fileName=';

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
  static const String addVRProduct = '${baseUrl}Merchant/addVrImageProduct/';
  static const String addARProduct = '${baseUrl}Merchant/addArImageProduct/';
  static const String addARImageProduct = '${baseUrl}Merchant/addArImageProduct/';
  static const String addOfferProduct = '${baseUrl}Merchant/addOffer';
  static const String addCategories = '${baseUrl}Merchant/addingCategorie';
  static const String updateCategories = '${baseUrl}Merchant/updateCategorie/';
  static const String deleteCategories = '${baseUrl}Merchant/deleteCategorie/';
  static const String addToHotSelling = '${baseUrl}Merchant/addToHotSelling/';
  //get api
  static const String getCategories = '${baseUrl}allUsers/getCategorie/';
  static const String getProfile = '${baseUrl}Merchant/getProfile';
  //Order
  static const String getOrdersForMerchantProducts = '${baseUrl}Merchant/getOrdersForMerchant';
  static const String getMerchantProducts = '${baseUrl}allUsers/MerchantProducts/';
  static const String getOrderById = '${baseUrl}allUsers/getOrderById';
  static const String changeOrderStatus = '${baseUrl}allUsers/ChangeOrderStatus';
  //advanced Search
  static const String advancedSearch = '${baseUrl}allUsers/SearchProduct';

  //disputed
  static const String getDisputeById = '${baseUrl}Merchant/getDispute/';
  static const String getAllDispute = '${baseUrl}Merchant/getAllDispute';
  static const String deleteDispute = '${baseUrl}Merchant/deleteDispute/';
  static const String convertProcessDispute = '${baseUrl}Merchant/processDispute/';
  static const String convertResolveDispute = '${baseUrl}Merchant/resolveDispute/';
  static const String sendCommentDispute = '${baseUrl}allUsers/addComment/';
  static const String addDispute = '${baseUrl}allUsers/addDispute';

}
