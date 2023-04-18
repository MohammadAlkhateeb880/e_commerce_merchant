class MailVerificationResponse {
  String? message;
  bool? status;
  String? pin;

  MailVerificationResponse({this.message, this.status, this.pin});

  MailVerificationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['pin'] = pin;
    return data;
  }
}
