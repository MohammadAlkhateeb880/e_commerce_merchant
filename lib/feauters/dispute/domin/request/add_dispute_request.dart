import 'dart:io';
import 'package:dio/dio.dart';

class AddDisputeRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? orderId;
  String? typeUser;
  String? typeDispute;
  String? message;
  File? disputeImage;

  AddDisputeRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.orderId,
      this.typeUser,
      this.typeDispute,
      this.message,
      this.disputeImage});

  AddDisputeRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    orderId = json['order_id'];
    typeUser = json['type_User'];
    typeDispute = json['type_Dispute'];
    message = json['message'];
    disputeImage = json['disputeImage'];
  }

  Future<Map<String, dynamic>> toJson({required File disputeImage}) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['order_id'] = orderId;
    data['type_User'] = typeUser;
    data['type_Dispute'] = typeDispute;
    data['message'] = message;
    data['disputeImage'] = await MultipartFile.fromFile(disputeImage.path);
    return data;
  }
}
