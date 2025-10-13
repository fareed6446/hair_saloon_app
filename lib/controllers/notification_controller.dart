import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../services/hive_service.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    final cachedNotifications = HiveService.getNotifications();
    notifications.value = cachedNotifications;
    _updateUnreadCount();
  }

  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !n.isRead).length;
  }

  Future<void> markAsRead(String notificationId) async {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index].markAsRead();
      _updateUnreadCount();
      notifications.refresh();
    }
  }

  Future<void> markAllAsRead() async {
    for (var notification in notifications) {
      if (!notification.isRead) {
        notification.markAsRead();
      }
    }
    _updateUnreadCount();
    notifications.refresh();
  }

  Future<void> deleteNotification(String notificationId) async {
    notifications.removeWhere((n) => n.id == notificationId);
    _updateUnreadCount();
  }

  List<NotificationModel> get unreadNotifications {
    return notifications.where((n) => !n.isRead).toList();
  }

  List<NotificationModel> get readNotifications {
    return notifications.where((n) => n.isRead).toList();
  }
}
