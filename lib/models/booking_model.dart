import 'package:hive/hive.dart';
import 'service_model.dart';
import 'stylist_model.dart';
import 'user_model.dart';

part 'booking_model.g.dart';

@HiveType(typeId: 3)
class BookingModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String serviceId;

  @HiveField(3)
  final String? packageId;

  @HiveField(4)
  final String? stylistId;

  @HiveField(5)
  final DateTime dateTime;

  @HiveField(6)
  String status; // booked, cancelled, completed, no_show

  @HiveField(7)
  int loyaltyPointsAwarded;

  @HiveField(8)
  String? notes;

  @HiveField(9)
  final DateTime createdAt;

  // Non-Hive fields (for expanded data from API)
  UserModel? user;
  ServiceModel? service;
  ServicePackage? package;
  StylistModel? stylist;

  BookingModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    this.packageId,
    this.stylistId,
    required this.dateTime,
    this.status = 'booked',
    this.loyaltyPointsAwarded = 0,
    this.notes,
    required this.createdAt,
    this.user,
    this.service,
    this.package,
    this.stylist,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String? ?? json['user_id'] as String,
      serviceId: json['serviceId'] as String? ?? json['service_id'] as String,
      packageId: json['packageId'] as String? ?? json['package_id'] as String?,
      stylistId: json['stylistId'] as String? ?? json['stylist_id'] as String?,
      dateTime: DateTime.parse(
        json['dateTime'] as String? ?? json['date_time'] as String,
      ),
      status: json['status'] as String? ?? 'booked',
      loyaltyPointsAwarded:
          (json['loyaltyPointsAwarded'] as int?) ??
          (json['loyaltyPointsAwarded'] as int?) ??
          0,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'] as Map<String, dynamic>)
          : null,
      package: json['package'] != null
          ? ServicePackage.fromJson(json['package'] as Map<String, dynamic>)
          : null,
      stylist: json['stylist'] != null
          ? StylistModel.fromJson(json['stylist'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceId': serviceId,
      'packageId': packageId,
      'stylistId': stylistId,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'loyaltyPointsAwarded': loyaltyPointsAwarded,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool get isUpcoming => dateTime.isAfter(DateTime.now()) && status == 'booked';
  bool get isPast => dateTime.isBefore(DateTime.now());
  bool get isCancelled => status == 'cancelled';
  bool get isCompleted => status == 'completed';
}
