class LoginRequest {
  String? nameOrEmail;
  String? password;

  LoginRequest({this.nameOrEmail, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    nameOrEmail = json['nameOrEmail'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameOrEmail'] = nameOrEmail;
    data['password'] = password;
    return data;
  }
}
