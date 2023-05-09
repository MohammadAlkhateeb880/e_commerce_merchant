class AddCategoryResponse {
  String? message;
  bool? status;
  Data? data;

  AddCategoryResponse({this.message, this.status, this.data});

  AddCategoryResponse.fromJson(Map<String, dynamic> json) {
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
  Categorie? categorie;

  Data({this.categorie});

  Data.fromJson(Map<String, dynamic> json) {
    categorie = json['categorie'] != null
        ? Categorie.fromJson(json['categorie'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categorie != null) {
      data['categorie'] = categorie!.toJson();
    }
    return data;
  }
}

class Categorie {
  String? imageOfCate;
  String? arName;
  String? enName;
  String? merchantId;
  bool? homePage;
  String? sId;
  String? updatedAt;
  String? createdAt;
  int? iV;

  Categorie(
      {this.imageOfCate,
        this.arName,
        this.enName,
        this.merchantId,
        this.homePage,
        this.sId,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Categorie.fromJson(Map<String, dynamic> json) {
    imageOfCate = json['ImageOfCate'];
    arName = json['arName'];
    enName = json['enName'];
    merchantId = json['MerchantId'];
    homePage = json['HomePage'];
    sId = json['_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ImageOfCate'] = imageOfCate;
    data['arName'] = arName;
    data['enName'] = enName;
    data['MerchantId'] = merchantId;
    data['HomePage'] = homePage;
    data['_id'] = sId;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
