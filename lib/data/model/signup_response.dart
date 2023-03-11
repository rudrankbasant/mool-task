class SignUpResponse {
  String? message;

  SignUpResponse({this.message});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['Success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.message;
    return data;
  }
}