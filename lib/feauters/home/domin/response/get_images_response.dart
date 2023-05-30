class GetImagesResponse {
  String? message;
  bool? status;
  Data? data;

  GetImagesResponse({this.message, this.status, this.data});

  GetImagesResponse.fromJson(Map<String, dynamic> json) {
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
  Gallery? gallery;

  Data({this.gallery});

  Data.fromJson(Map<String, dynamic> json) {
    gallery =
    json['gallery'] != null ? Gallery.fromJson(json['gallery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gallery != null) {
      data['gallery'] = gallery!.toJson();
    }
    return data;
  }
}

class Gallery {
  String? sId;
  List<String>? gallery;
  String? mainImage;

  Gallery({this.sId, this.gallery, this.mainImage});

  Gallery.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gallery = json['gallery'].cast<String>();
    mainImage = json['mainImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['gallery'] = gallery;
    data['mainImage'] = mainImage;
    return data;
  }
}
