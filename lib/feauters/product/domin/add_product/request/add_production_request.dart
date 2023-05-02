class AddProductionRequest {
  String? name;
  String? mainCategorie;
  String? descreption;
  String? manufacturingMaterial;
  String? guarantee;
  List<Class>? classes;

  AddProductionRequest({this.name, this.mainCategorie, this.descreption, this.manufacturingMaterial, this.guarantee, this.classes});

  AddProductionRequest.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  mainCategorie = json['mainCategorie'];
  descreption = json['descreption'];
  manufacturingMaterial = json['manufacturingMaterial'];
  guarantee = json['Guarantee'];
  if (json['Class'] != null) {
  classes = <Class>[];
  json['Class'].forEach((v) { classes!.add(Class.fromJson(v)); });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = name;
  data['mainCategorie'] = mainCategorie;
  data['descreption'] = descreption;
  data['manufacturingMaterial'] = manufacturingMaterial;
  data['Guarantee'] = guarantee;
  if (classes != null) {
  data['Class'] = classes!.map((v) => v.toJson()).toList();
  }
  return data;
  }
}

class Class {
  String? width;
  String? length;
  String? size;
  String? price;
  bool? sallableInPoints;
  List<Group>? group;

  Class({this.width, this.length, this.size, this.price, this.sallableInPoints, this.group});

  Class.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    length = json['length'];
    size = json['size'];
    price = json['price'];
    sallableInPoints = json['sallableInPoints'];
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) { group!.add(Group.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['length'] = length;
    data['size'] = size;
    data['price'] = price;
    data['sallableInPoints'] = sallableInPoints;
    if (group != null) {
      data['group'] = group!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
  int? quantity;
  String? color;

  Group({this.quantity, this.color});

  Group.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['color'] = color;
    return data;
  }
}
