class RegisterModel {
  String? username;
  String? password;
  String? fullName;
  String? dateOfBirth;

  RegisterModel(
      {this.username, this.password, this.fullName, this.dateOfBirth});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    fullName = json['fullName'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['fullName'] = fullName;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }
}
