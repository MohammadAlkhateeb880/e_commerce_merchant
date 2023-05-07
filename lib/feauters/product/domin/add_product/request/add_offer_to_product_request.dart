class AddOfferToProductsRequest {
  String? endDateOfOffers;
  String? startDateOfOffers;
  int? valueOfOffer;
  String? typeOfOffer;
  List<String>? productsIds;

  AddOfferToProductsRequest(
      {this.endDateOfOffers,
        this.startDateOfOffers,
        this.valueOfOffer,
        this.typeOfOffer,
        this.productsIds});

  AddOfferToProductsRequest.fromJson(Map<String, dynamic> json) {
    endDateOfOffers = json['endDateOfOffers'];
    startDateOfOffers = json['startDateOfOffers'];
    valueOfOffer = json['valueOfOffer'];
    typeOfOffer = json['typeOfOffer'];
    productsIds = json['productsIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['endDateOfOffers'] = endDateOfOffers;
    data['startDateOfOffers'] = startDateOfOffers;
    data['valueOfOffer'] = valueOfOffer;
    data['typeOfOffer'] = typeOfOffer;
    data['productsIds'] = productsIds;
    return data;
  }
}
