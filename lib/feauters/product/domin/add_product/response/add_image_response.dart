class AddImageProductResponse {
  String? message;
  bool? status;
  Data? data;

  AddImageProductResponse({this.message, this.status, this.data});

  AddImageProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Product? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  List<String>? gallery;
  String? mainImage;

  Product({this.sId, this.name, this.gallery, this.mainImage});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    gallery = json['gallery'].cast<String>();
    mainImage = json['mainImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['gallery'] = gallery;
    data['mainImage'] = mainImage;
    return data;
  }
}
