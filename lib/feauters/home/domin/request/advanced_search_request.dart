class AdvancedSearchRequest {
  String? name;
  String? color;
  int? price;
  String? mainCategorie;
  bool? homePage;
  String? finished;
  String? manufacturingMaterial;

  AdvancedSearchRequest(
      {this.name,
        this.color,
        this.price,
        this.mainCategorie,
        this.homePage,
        this.finished,
        this.manufacturingMaterial});

  AdvancedSearchRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    price = json['price'];
    mainCategorie = json['mainCategorie'];
    homePage = json['HomePage'];
    finished = json['finished'];
    manufacturingMaterial = json['manufacturingMaterial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    data['price'] = this.price;
    data['mainCategorie'] = this.mainCategorie;
    data['HomePage'] = this.homePage;
    data['finished'] = this.finished;
    data['manufacturingMaterial'] = this.manufacturingMaterial;
    return data;
  }
}
