import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String fullName;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String? email;

  @HiveField(4)
  int loyaltyPoints;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  String? token;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    this.loyaltyPoints = 0,
    required this.createdAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      loyaltyPoints: (json['loyaltyPoints'] as int?) ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'loyaltyPoints': loyaltyPoints,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phone,
    String? email,
    int? loyaltyPoints,
    DateTime? createdAt,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      createdAt: createdAt ?? this.createdAt,
      token: token ?? this.token,
    );
  }
}
