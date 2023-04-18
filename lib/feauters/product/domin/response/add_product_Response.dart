class AddProductResponse {
  String? message;
  bool? status;
  Data? data;

  AddProductResponse({this.message, this.status, this.data});

  AddProductResponse.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? descreption;
  String? mainCategorie;
  String? sId;

  Product({this.name, this.descreption, this.mainCategorie, this.sId});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    descreption = json['descreption'];
    mainCategorie = json['mainCategorie'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['descreption'] = descreption;
    data['mainCategorie'] = mainCategorie;
    data['_id'] = sId;
    return data;
  }
}
