class ProfileResponse {
  String? message;
  bool? status;
  Data? data;

  ProfileResponse({this.message, this.status, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  KycDoucoments? kycDoucoments;
  String? sId;
  String? fullName;
  String? email;
  String? marketName;
  String? marketLogo;
  String? phone;
  int? role;
  String? address;
  String? updatedAt;
  String? createdAt;
  int? iV;

  User(
      {this.kycDoucoments,
        this.sId,
        this.fullName,
        this.email,
        this.marketName,
        this.marketLogo,
        this.phone,
        this.role,
        this.address,
        this.updatedAt,
        this.createdAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    kycDoucoments = json['kycDoucoments'] != null
        ? KycDoucoments.fromJson(json['kycDoucoments'])
        : null;
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    marketName = json['marketName'];
    marketLogo = json['marketLogo'];
    phone = json['phone'];
    role = json['role'];
    address = json['address'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (kycDoucoments != null) {
      data['kycDoucoments'] = kycDoucoments!.toJson();
    }
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['marketName'] = marketName;
    data['marketLogo'] = marketLogo;
    data['phone'] = phone;
    data['role'] = role;
    data['address'] = address;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class KycDoucoments {
  String? businesslicense;
  String? nameOFBank;
  String? nameOfBrand;
  String? iban;
  String? addressOfBank;

  KycDoucoments(
      {this.businesslicense,
        this.nameOFBank,
        this.nameOfBrand,
        this.iban,
        this.addressOfBank});

  KycDoucoments.fromJson(Map<String, dynamic> json) {
    businesslicense = json['businesslicense'];
    nameOFBank = json['nameOFBank'];
    nameOfBrand = json['nameOfBrand'];
    iban = json['iban'];
    addressOfBank = json['addressOfBank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businesslicense'] = businesslicense;
    data['nameOFBank'] = nameOFBank;
    data['nameOfBrand'] = nameOfBrand;
    data['iban'] = iban;
    data['addressOfBank'] = addressOfBank;
    return data;
  }
}
