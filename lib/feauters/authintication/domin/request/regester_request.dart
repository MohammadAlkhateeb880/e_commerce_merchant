

import 'dart:io';
import 'package:dio/dio.dart';

class RegisterRequest {
  String? fullName;
  String? email;
  String? phone;
  String? password;
  String? pin;
  String? marketName;
  File? marketLogo;
  String? iban;
  String? nameOFBank;
  String? addressOfBank;
  String? nameOfBrand;
  String? taxNumber;
  File? businesslicense;
  String? address;

  RegisterRequest(
      {this.fullName,
        this.email,
        this.phone,
        this.password,
        this.pin,
        this.marketName,
        this.marketLogo,
        this.iban,
        this.nameOFBank,
        this.addressOfBank,
        this.nameOfBrand,
        this.taxNumber,
        this.businesslicense,
        this.address});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    pin = json['pin'];
    marketName = json['marketName'];
    marketLogo = json['marketLogo'];
    iban = json['iban'];
    nameOFBank = json['nameOFBank'];
    addressOfBank = json['addressOfBank'];
    nameOfBrand = json['nameOfBrand'];
    taxNumber = json['taxNumber'];
    businesslicense = json['businesslicense'];
    address = json['address'];
  }

  Future<Map<String, dynamic>> toJson({
  required File marketLogo,
  required File businessLicence,
}) async{
      Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['pin'] = pin;
    data['marketName'] = marketName;
    data['marketLogo'] = await MultipartFile.fromFile(marketLogo.path);
    data['iban'] = iban;
    data['nameOFBank'] = nameOFBank;
    data['addressOfBank'] = addressOfBank;
    data['nameOfBrand'] = nameOfBrand;
    data['taxNumber'] = taxNumber;
    data['businesslicense'] = await MultipartFile.fromFile(businessLicence.path);
    data['address'] = address;
    return  data;
  }
}
