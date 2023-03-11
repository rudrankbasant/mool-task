class UserResponse {
  int? id;
  String? fullname;
  String? username;
  String? profilePic;

  UserResponse({this.id, this.fullname, this.username, this.profilePic});

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}