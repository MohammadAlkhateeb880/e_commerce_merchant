class GetMerchantResponse {
  String? message;
  bool? status;
  Data? data;

  GetMerchantResponse({this.message, this.status, this.data});

  GetMerchantResponse.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;

  Data({this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? name;
  String? mainCategorie;
  List<Classes>? classes;
  int? guarantee;
  String? manufacturingMaterial;

  Products(
      {this.sId,
      this.name,
      this.mainCategorie,
      this.classes,
      this.guarantee,
      this.manufacturingMaterial});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mainCategorie = json['mainCategorie'];
    if (json['Class'] != null) {
      classes = <Classes>[];
      json['Class'].forEach((v) {
        classes!.add(Classes.fromJson(v));
      });
    }
    guarantee = json['Guarantee'];
    manufacturingMaterial = json['manufacturingMaterial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['mainCategorie'] = mainCategorie;
    if (classes != null) {
      data['Class'] = classes!.map((v) => v.toJson()).toList();
    }
    data['Guarantee'] = guarantee;
    data['manufacturingMaterial'] = manufacturingMaterial;
    return data;
  }
}

class Classes {
  String? size;
  int? length;
  int? width;
  int? price;
  bool? sallableInPoints;
  List<Group>? group;
  String? sId;
  int? priceAfterDiscount;

  Classes(
      {this.size,
      this.length,
      this.width,
      this.price,
      this.sallableInPoints,
      this.group,
      this.sId,
      this.priceAfterDiscount});

  Classes.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    length = json['length'];
    width = json['width'];
    price = json['price'];
    sallableInPoints = json['sallableInPoints'];
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) {
        group!.add(Group.fromJson(v));
      });
    }
    sId = json['_id'];
    priceAfterDiscount = json['priceAfterDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['length'] = length;
    data['width'] = width;
    data['price'] = price;
    data['sallableInPoints'] = sallableInPoints;
    if (group != null) {
      data['group'] = group!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['priceAfterDiscount'] = priceAfterDiscount;
    return data;
  }
}

class Group {
  String? color;
  int? quantity;
  String? sId;

  Group({this.color, this.quantity, this.sId});

  Group.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
