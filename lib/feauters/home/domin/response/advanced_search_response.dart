class AdvancedSearchResponse {
  List<SearchResponseProducts>? products;

  AdvancedSearchResponse({this.products});

  AdvancedSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <SearchResponseProducts>[];
      json['products'].forEach((v) {
        products!.add(SearchResponseProducts.fromJson(v));
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

  class SearchResponseProducts {
  String? sId;
  String? name;
  String? descreption;
  String? mainCategorie;
  List<Classes>? classes;
  List<String>? gallery;
  String? ownerId;
  bool? homePage;
  int? guarantee;
  String? manufacturingMaterial;
  List<DeliveryAreas>? deliveryAreas;
  String? updatedAt;
  String? createdAt;
  int? iV;
  String? mainImage;

  SearchResponseProducts(
      {this.sId,
        this.name,
        this.descreption,
        this.mainCategorie,
        this.classes,
        this.gallery,
        this.ownerId,
        this.homePage,
        this.guarantee,
        this.manufacturingMaterial,
        this.deliveryAreas,
        this.updatedAt,
        this.createdAt,
        this.iV,
        this.mainImage});

  SearchResponseProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    descreption = json['descreption'];
    mainCategorie = json['mainCategorie'];
    if (json['Classes'] != null) {
      classes = <Classes>[];
      json['Classes'].forEach((v) {
        classes!.add(Classes.fromJson(v));
      });
    }
    gallery = json['gallery'].cast<String>();
    ownerId = json['owner_id'];
    homePage = json['HomePage'];
    guarantee = json['Guarantee'];
    manufacturingMaterial = json['manufacturingMaterial'];
    if (json['deliveryAreas'] != null) {
      deliveryAreas = <DeliveryAreas>[];
      json['deliveryAreas'].forEach((v) {
        deliveryAreas!.add(DeliveryAreas.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    mainImage = json['mainImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['descreption'] = descreption;
    data['mainCategorie'] = mainCategorie;
    if (classes != null) {
      data['Classes'] = classes!.map((v) => v.toJson()).toList();
    }
    data['gallery'] = gallery;
    data['owner_id'] = ownerId;
    data['HomePage'] = homePage;
    data['Guarantee'] = guarantee;
    data['manufacturingMaterial'] = manufacturingMaterial;
    if (deliveryAreas != null) {
      data['deliveryAreas'] =
          deliveryAreas!.map((v) => v.toJson()).toList();
    }
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['mainImage'] = mainImage;
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

class DeliveryAreas {
  String? location;
  int? deliveryPrice;
  String? sId;

  DeliveryAreas({this.location, this.deliveryPrice, this.sId});

  DeliveryAreas.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    deliveryPrice = json['deliveryPrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['deliveryPrice'] = deliveryPrice;
    data['_id'] = sId;
    return data;
  }
}
