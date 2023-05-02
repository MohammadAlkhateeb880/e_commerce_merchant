class AddDeliveryAreasRequest {
  List<Areas>? areas;

  AddDeliveryAreasRequest({this.areas});

  AddDeliveryAreasRequest.fromJson(Map<String, dynamic> json) {
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (areas != null) {
      data['areas'] = areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  String? location;
  int? deliveryPrice;

  Areas({this.location, this.deliveryPrice});

  Areas.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    deliveryPrice = json['deliveryPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['deliveryPrice'] = deliveryPrice;
    return data;
  }
}
