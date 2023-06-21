class GetAllDisputedResponse {
  String? message;
  bool? status;
  List<Data>? data;

  GetAllDisputedResponse({this.message, this.status, this.data});

  GetAllDisputedResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? message;
  String? disputeImage;
  String? status;
  String? typeUser;
  String? typeDispute;
  List<Notes>? notes;
  int? disputeID;
  String? updatedAt;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.message,
        this.disputeImage,
        this.status,
        this.typeUser,
        this.typeDispute,
        this.notes,
        this.disputeID,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    message = json['message'];
    disputeImage = json['disputeImage'];
    status = json['status'];
    typeUser = json['type_User'];
    typeDispute = json['type_Dispute'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
    disputeID = json['disputeID'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['message'] = message;
    data['disputeImage'] = disputeImage;
    data['status'] = status;
    data['type_User'] = typeUser;
    data['type_Dispute'] = typeDispute;
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    data['disputeID'] = disputeID;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class Notes {
  String? ownerId;
  String? message;
  String? createdAt;

  Notes({this.ownerId, this.message, this.createdAt});

  Notes.fromJson(Map<String, dynamic> json) {
    ownerId = json['owner_id'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner_id'] = ownerId;
    data['message'] = message;
    data['createdAt'] = createdAt;
    return data;
  }
}
