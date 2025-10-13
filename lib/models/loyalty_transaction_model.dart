import 'package:hive/hive.dart';

part 'loyalty_transaction_model.g.dart';

@HiveType(typeId: 6)
class LoyaltyTransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  String type; // 'earn' or 'redeem'

  @HiveField(3)
  int points;

  @HiveField(4)
  String? reference; // bookingId or couponId

  @HiveField(5)
  final DateTime createdAt;

  LoyaltyTransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.points,
    this.reference,
    required this.createdAt,
  });

  factory LoyaltyTransactionModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyTransactionModel(
      id: json['id'] as String,
      userId: json['userId'] as String? ?? json['user_id'] as String,
      type: json['type'] as String,
      points: (json['points'] as num).toInt(),
      reference: json['reference'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'points': points,
      'reference': reference,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool get isEarning => type == 'earn';
  bool get isRedemption => type == 'redeem';
}
