import 'package:hive/hive.dart';

part 'stylist_model.g.dart';

@HiveType(typeId: 4)
class StylistModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> specialties;

  @HiveField(3)
  double? rating;

  @HiveField(4)
  bool isActive;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  String? imageUrl;

  StylistModel({
    required this.id,
    required this.name,
    this.specialties = const [],
    this.rating,
    this.isActive = true,
    required this.createdAt,
    this.imageUrl,
  });

  factory StylistModel.fromJson(Map<String, dynamic> json) {
    List<String> parseSpecialties(dynamic specialtiesData) {
      if (specialtiesData == null) return [];
      if (specialtiesData is List) {
        return specialtiesData.map((e) => e.toString()).toList();
      }
      if (specialtiesData is String) {
        // Handle comma-separated string or JSON string
        if (specialtiesData.startsWith('[')) {
          // Comma-separated string (just split it)
          return specialtiesData.split(',').map((e) => e.trim()).toList();
        } else {
          // Comma-separated string
          return specialtiesData.split(',').map((e) => e.trim()).toList();
        }
      }
      return [];
    }

    return StylistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      specialties: parseSpecialties(json['specialties']),
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      isActive: json['isActive'] == 1 || json['isActive'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialties': specialties,
      'rating': rating,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}
