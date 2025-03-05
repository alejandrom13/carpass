import 'dart:convert';

class PricingModel {
  int? id;
  String? name;
  double? price;
  String? description;
  int? discount;
  int? credits;
  String? variantId;
  bool? recommended;
  DateTime? createdAt;

  PricingModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.discount,
    this.credits,
    this.variantId,
    this.recommended,
    this.createdAt,
  });

  PricingModel copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
    int? discount,
    int? credits,
    String? variantId,
    bool? recommended,
    DateTime? createdAt,
  }) =>
      PricingModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
        discount: discount ?? this.discount,
        credits: credits ?? this.credits,
        variantId: variantId ?? this.variantId,
        recommended: recommended ?? this.recommended,
        createdAt: createdAt ?? this.createdAt,
      );

  factory PricingModel.fromRawJson(String str) =>
      PricingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble() / 100,
        description: json["description"],
        discount: json["discount"],
        credits: json["credits"],
        variantId: json["variantId"],
        recommended: json["recommended"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price!,
        "description": description,
        "discount": discount,
        "credits": credits,
        "variantId": variantId,
        "recommended": recommended,
        "createdAt": createdAt?.toIso8601String(),
      };
}
