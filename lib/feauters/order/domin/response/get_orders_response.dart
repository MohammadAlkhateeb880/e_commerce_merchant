

    class GetOrdersResponse {
    String? message;
    bool? status;
    List<OrderData>? data;

    GetOrdersResponse({this.message, this.status, this.data});

    GetOrdersResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
    data = <OrderData>[];
    json['data'].forEach((v) {
    data!.add(OrderData.fromJson(v));
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

    class OrderData {
    UserInfo? userInfo;
    ShippingAddress? shippingAddress;
    String? sId;
    User? user;
    String? status;
    int? totalPrice;
    String? paymentMethod;
    String? paymentStatus;
    String? updatedAt;
    String? createdAt;
    int? iV;
    int? itemsCount;
    String? shippingDate;

    OrderData(
    {this.userInfo,
    this.shippingAddress,
    this.sId,
    this.user,
    this.status,
    this.totalPrice,
    this.paymentMethod,
    this.paymentStatus,
    this.updatedAt,
    this.createdAt,
    this.iV,
    this.itemsCount,
    this.shippingDate});

    OrderData.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
    ? UserInfo.fromJson(json['userInfo'])
    : null;
    shippingAddress = json['shippingAddress'] != null
    ? ShippingAddress.fromJson(json['shippingAddress'])
    : null;
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    status = json['status'];
    totalPrice = json['totalPrice'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    itemsCount = json['itemsCount'];
    shippingDate = json['shippingDate'];
    }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
    data['userInfo'] = userInfo!.toJson();
    }
    if (shippingAddress != null) {
    data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['_id'] = sId;
    if (user != null) {
    data['user'] = user!.toJson();
    }
    data['status'] = status;
    data['totalPrice'] = totalPrice;
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['itemsCount'] = itemsCount;
    data['shippingDate'] = shippingDate;
    return data;
    }
    }

    class UserInfo {
    String? firstName;
    String? lastName;
    String? email;
    int? phone;

    UserInfo({this.firstName, this.lastName, this.email, this.phone});

    UserInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
    }
    }

    class ShippingAddress {
    String? country;
    String? city;
    String? region;
    int? streetNumber;
    int? houseNumber;
    String? description;

    ShippingAddress(
    {this.country,
    this.city,
    this.region,
    this.streetNumber,
    this.houseNumber,
    this.description});

    ShippingAddress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    region = json['region'];
    streetNumber = json['streetNumber'];
    houseNumber = json['houseNumber'];
    description = json['description'];
    }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['city'] = city;
    data['region'] = region;
    data['streetNumber'] = streetNumber;
    data['houseNumber'] = houseNumber;
    data['description'] = description;
    return data;
    }
    }

    class User {
    String? sId;
    String? fullName;
    String? email;
    int? role;
    String? address;
    String? updatedAt;
    String? createdAt;
    int? iV;

    User(
    {this.sId,
    this.fullName,
    this.email,
    this.role,
    this.address,
    this.updatedAt,
    this.createdAt,
    this.iV});

    User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    address = json['address'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['role'] = role;
    data['address'] = address;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
    }
    }


