import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? email;
  String? name;

  LoginModel({
    this.email,
    this.name,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
    };
  }

  copyWith({
    String? email,
    String? name,
  }) {
    return LoginModel(
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}

class User {
  String? name;
  String? email;

  User({
    this.email,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
      );
}
