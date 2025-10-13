import 'package:hive/hive.dart';

part 'service_model.g.dart';

@HiveType(typeId: 1)
class ServiceModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  double basePrice;

  @HiveField(4)
  int durationMinutes;

  @HiveField(5)
  String? imageUrl;

  @HiveField(6)
  String? categoryId;

  @HiveField(7)
  bool isActive;

  @HiveField(8)
  final DateTime createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  @HiveField(10)
  List<ServicePackage> packages;

  ServiceModel({
    required this.id,
    required this.title,
    this.description,
    required this.basePrice,
    required this.durationMinutes,
    this.imageUrl,
    this.categoryId,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
    this.packages = const [],
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      basePrice: (json['basePrice'] as num).toDouble(),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      categoryId: json['categoryId'] as String?,
      isActive: json['isActive'] == 1 || json['isActive'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      packages:
          (json['packages'] as List<dynamic>?)
              ?.map((p) => ServicePackage.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'basePrice': basePrice,
      'durationMinutes': durationMinutes,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'packages': packages.map((p) => p.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 2)
class ServicePackage extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String serviceId;

  @HiveField(2)
  String name;

  @HiveField(3)
  double price;

  @HiveField(4)
  int durationMinutes;

  @HiveField(5)
  String? details;

  @HiveField(6)
  final DateTime createdAt;

  ServicePackage({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.price,
    required this.durationMinutes,
    this.details,
    required this.createdAt,
  });

  factory ServicePackage.fromJson(Map<String, dynamic> json) {
    return ServicePackage(
      id: json['id'] as String,
      serviceId: json['serviceId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      details: json['details'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'name': name,
      'price': price,
      'durationMinutes': durationMinutes,
      'details': details,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
