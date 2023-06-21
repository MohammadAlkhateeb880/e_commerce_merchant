// class GetMerchantResponse {
//   GetMerchantResponse({
//     this.message,
//     this.status,
//     this.data,
//   });
//
//   final String? message;
//   final bool? status;
//   final Data? data;
//
//   GetMerchantResponse copyWith({
//     String? message,
//     bool? status,
//     Data? data,
//   }) {
//     return GetMerchantResponse(
//       message: message ?? this.message,
//       status: status ?? this.status,
//       data: data ?? this.data,
//     );
//   }
//
//   factory GetMerchantResponse.fromJson(Map<String, dynamic> json) {
//     return GetMerchantResponse(
//       message: json["message"],
//       status: json["status"],
//       data:
//       json["data"] == null ? null : Data.fromJson(json["data"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "status": status,
//     "data": data?.toJson(),
//   };
//
//   @override
//   String toString() {
//     return "$message, $status, $data, ";
//   }
// }
//
// class Data {
//   Data({
//     required this.products,
//   });
//
//   final List<Product> products;
//
//   Data copyWith({
//     List<Product>? products,
//   }) {
//     return Data(
//       products: products ?? this.products,
//     );
//   }
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       products: json["products"] == null
//           ? []
//           : List<Product>.from(
//           json["products"]!.map((x) => Product.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "products": products.map((x) => x.toJson()).toList(),
//   };
//
//   @override
//   String toString() {
//     return "$products, ";
//   }
// }
//
// class Product {
//   Product({
//     required this.id,
//     required this.name,
//     required this.mainCategorie,
//     required this.classes,
//     required this.guarantee,
//     required this.manufacturingMaterial,
//     required this.mainImage,
//   });
//
//   final String? id;
//   final String? name;
//   final String? mainCategorie;
//   final List<Classes> classes;
//   final int? guarantee;
//   final String? manufacturingMaterial;
//   final String? mainImage;
//
//   Product copyWith({
//     String? id,
//     String? name,
//     String? mainCategorie,
//     List<Classes>? classes,
//     int? guarantee,
//     String? manufacturingMaterial,
//     String? mainImage,
//   }) {
//     return Product(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       mainCategorie: mainCategorie ?? this.mainCategorie,
//       classes: classes ?? this.classes,
//       guarantee: guarantee ?? this.guarantee,
//       manufacturingMaterial:
//       manufacturingMaterial ?? this.manufacturingMaterial,
//       mainImage: mainImage ?? this.mainImage,
//     );
//   }
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json["_id"],
//       name: json["name"],
//       mainCategorie: json["mainCategorie"],
//       classes: json["Class"] == null
//           ? []
//           : List<Classes>.from(
//           json["Class"]!.map((x) => Classes.fromJson(x))),
//       guarantee: json["Guarantee"],
//       manufacturingMaterial: json["manufacturingMaterial"],
//       mainImage: json["mainImage"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "mainCategorie": mainCategorie,
//     "Class": classes.map((x) => x.toJson()).toList(),
//     "Guarantee": guarantee,
//     "manufacturingMaterial": manufacturingMaterial,
//     "mainImage": mainImage,
//   };
//
//   @override
//   String toString() {
//     return "$id, $name, $mainCategorie, $classes, $guarantee, $manufacturingMaterial, $mainImage, ";
//   }
// }
//
// class Classes {
//   Classes({
//     required this.size,
//     required this.length,
//     required this.width,
//     required this.price,
//     required this.sallableInPoints,
//     required this.group,
//     required this.sId,
//     required this.priceAfterDiscount,
//   });
//
//   final String? size;
//   final int? length;
//   final int? width;
//   final int? price;
//   final bool? sallableInPoints;
//   final List<Group> group;
//   final String? sId;
//   final int? priceAfterDiscount;
//
//   Classes copyWith({
//     String? size,
//     int? length,
//     int? width,
//     int? price,
//     bool? sallableInPoints,
//     List<Group>? group,
//     String? sId,
//     int? priceAfterDiscount,
//   }) {
//     return Classes(
//       size: size ?? this.size,
//       length: length ?? this.length,
//       width: width ?? this.width,
//       price: price ?? this.price,
//       sallableInPoints: sallableInPoints ?? this.sallableInPoints,
//       group: group ?? this.group,
//       sId: sId ?? this.sId,
//       priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
//     );
//   }
//
//   factory Classes.fromJson(Map<String, dynamic> json) {
//     return Classes(
//       size: json["size"],
//       length: json["length"],
//       width: json["width"],
//       price: json["price"],
//       sallableInPoints: json["sallableInPoints"],
//       group: json["group"] == null
//           ? []
//           : List<Group>.from(
//           json["group"]!.map((x) => Group.fromJson(x))),
//       sId: json["_id"],
//       priceAfterDiscount: json["priceAfterDiscount"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "size": size,
//     "length": length,
//     "width": width,
//     "price": price,
//     "sallableInPoints": sallableInPoints,
//     "group": group.map((x) => x.toJson()).toList(),
//     "_id": sId,
//     "priceAfterDiscount": priceAfterDiscount,
//   };
//
//   @override
//   String toString() {
//     return "$size, $length, $width, $price, $sallableInPoints, $group, $sId, $priceAfterDiscount, ";
//   }
// }
//
// class Group {
//   Group({
//     required this.color,
//     required this.quantity,
//     required this.id,
//   });
//
//   final String? color;
//   final int? quantity;
//   final String? id;
//
//   Group copyWith({
//     String? color,
//     int? quantity,
//     String? id,
//   }) {
//     return Group(
//       color: color ?? this.color,
//       quantity: quantity ?? this.quantity,
//       id: id ?? this.id,
//     );
//   }
//
//   factory Group.fromJson(Map<String, dynamic> json) {
//     return Group(
//       color: json["color"],
//       quantity: json["quantity"],
//       id: json["_id"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "color": color,
//     "quantity": quantity,
//     "_id": id,
//   };
//
//   @override
//   String toString() {
//     return "$color, $quantity, $id, ";
//   }
// }
