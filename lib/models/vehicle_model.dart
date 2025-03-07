class VehicleModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String vin;
  String brand;
  final String model;
  final int year;
  final String manufacturer;
  final String trim;
  final String type;
  final String plantCountry;
  final String plantCity;
  final String? imageUrl;
  final bool isUnlock;

  VehicleModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.vin,
    required this.brand,
    required this.model,
    required this.year,
    required this.manufacturer,
    required this.trim,
    required this.type,
    required this.plantCountry,
    required this.plantCity,
    required this.isUnlock,
    this.imageUrl,
  });

  /// Convierte un JSON en una instancia de `VehicleModel`
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']) ?? DateTime.now(),
      updatedAt: DateTime.parse(json['updatedAt']) ?? DateTime.now(),
      vin: json['vin'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? 0,
      manufacturer: json['manufacturer'] ?? '',
      trim: json['trim'] ?? '',
      type: json['type'] ?? '',
      plantCountry: json['plantCountry'] ?? '',
      plantCity: json['plantCity'] ?? '',
      isUnlock: json['hasReport'] ?? false,
      imageUrl: json['imageUrl'],
    );
  }

  /// Convierte la instancia de `VehicleModel` a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'vin': vin,
      'brand': brand,
      'model': model,
      'year': year,
      'manufacturer': manufacturer,
      'trim': trim,
      'type': type,
      'plantCountry': plantCountry,
      'plantCity': plantCity,
      'imageUrl': imageUrl,
    };
  }
}
