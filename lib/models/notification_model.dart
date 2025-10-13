import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 5)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  @HiveField(4)
  String? type;

  @HiveField(5)
  DateTime? scheduledFor;

  @HiveField(6)
  bool isRead;

  @HiveField(7)
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.type,
    this.scheduledFor,
    this.isRead = false,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      userId: json['userId'] as String? ?? json['user_id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String?,
      scheduledFor: json['scheduledFor'] != null
          ? DateTime.parse(json['scheduledFor'] as String)
          : json['scheduled_for'] != null
          ? DateTime.parse(json['scheduled_for'] as String)
          : null,
      isRead:
          json['isRead'] == 1 ||
          json['isRead'] == true ||
          json['is_read'] == 1 ||
          json['is_read'] == true,
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
      'title': title,
      'body': body,
      'type': type,
      'scheduledFor': scheduledFor?.toIso8601String(),
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  void markAsRead() {
    isRead = true;
    save();
  }
}
