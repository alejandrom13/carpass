import 'dart:convert';

import 'package:carpass/models/auth/login.dart';

enum AuthStatus {
  checking,
  authenticated,
  unauthenticated,
  verified,
}

enum AuthType { password, passwordless, google, none, signUp }

class AuthState {
  AuthStatus authStatus;
  User? user;
  String? errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.errorMessage = '',
      this.user});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}

AuthModel AuthModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String AuthModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String? name;
  String? email;
  String? password;
  String? code;
  AuthType? type;

  AuthModel({
    this.name,
    this.email,
    this.password,
    this.type,
    this.code,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() {
    switch (type) {
      case AuthType.password:
        return {"email": email, "password": password};
      case AuthType.passwordless:
        return {"email": email, "otp": code};
      default:
        return {"email": email};
    }
  }

  Map<String, dynamic> toSignUpJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
