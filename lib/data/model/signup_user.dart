class SignupUser {
  String? fullname;
  String? username;
  String? email;
  String? password;

  SignupUser({required this.fullname, required this.username, required this.email, required this.password});

  SignupUser.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}