import 'dart:convert';

class UserModel {
  String? id;
  String? email;
  String? image;
  String? name;
  bool? isVerified;
  int? credits;
  DateTime? createdAt;

  UserModel({
    this.id,
    this.email,
    this.image,
    this.name,
    this.isVerified,
    this.credits,
    this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? email,
    dynamic image,
    String? name,
    bool? isVerified,
    int? credits,
    DateTime? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        image: image ?? this.image,
        name: name ?? this.name,
        isVerified: isVerified ?? this.isVerified,
        credits: credits ?? this.credits,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        image: json["image"],
        name: json["name"],
        isVerified: json["isVerified"],
        credits: json["credits"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "image": image,
        "name": name,
        "isVerified": isVerified,
        "credits": credits,
        "createdAt": createdAt?.toIso8601String(),
      };
}
