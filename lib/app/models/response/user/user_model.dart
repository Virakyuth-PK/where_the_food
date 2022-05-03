class UserModel {
  String? userId;
  String? fullName;
  String? dateOfBirth;
  String? token;

  UserModel({this.userId, this.fullName, this.dateOfBirth, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    dateOfBirth = json['dateOfBirth'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['dateOfBirth'] = dateOfBirth;
    data['token'] = token;
    return data;
  }
}
