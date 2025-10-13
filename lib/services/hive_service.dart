import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';
import '../models/stylist_model.dart';
import '../models/notification_model.dart';
import '../models/loyalty_transaction_model.dart';
import '../constants/app_constants.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ServiceModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ServicePackageAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(BookingModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(StylistModelAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(NotificationModelAdapter());
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(LoyaltyTransactionModelAdapter());
    }

    // Open Boxes
    await Hive.openBox<UserModel>(AppConstants.userBox);
    await Hive.openBox<ServiceModel>(AppConstants.servicesBox);
    await Hive.openBox<BookingModel>(AppConstants.bookingsBox);
    await Hive.openBox<NotificationModel>(AppConstants.notificationsBox);
    await Hive.openBox<StylistModel>(AppConstants.stylistsBox);
    await Hive.openBox(AppConstants.settingsBox);
  }

  // User Operations
  static Box<UserModel> get userBox =>
      Hive.box<UserModel>(AppConstants.userBox);

  static Future<void> saveUser(UserModel user) async {
    await userBox.put(AppConstants.currentUserKey, user);
  }

  static UserModel? getCurrentUser() {
    return userBox.get(AppConstants.currentUserKey);
  }

  static Future<void> deleteUser() async {
    await userBox.delete(AppConstants.currentUserKey);
  }

  // Token Operations
  static Box get settingsBox => Hive.box(AppConstants.settingsBox);

  static Future<void> saveToken(String token) async {
    await settingsBox.put(AppConstants.authTokenKey, token);
  }

  static String? getToken() {
    return settingsBox.get(AppConstants.authTokenKey) as String?;
  }

  static Future<void> deleteToken() async {
    await settingsBox.delete(AppConstants.authTokenKey);
  }

  // Service Operations
  static Box<ServiceModel> get servicesBox =>
      Hive.box<ServiceModel>(AppConstants.servicesBox);

  static Future<void> saveServices(List<ServiceModel> services) async {
    await servicesBox.clear();
    for (var service in services) {
      await servicesBox.put(service.id, service);
    }
  }

  static List<ServiceModel> getServices() {
    return servicesBox.values.toList();
  }

  static ServiceModel? getService(String id) {
    return servicesBox.get(id);
  }

  // Booking Operations
  static Box<BookingModel> get bookingsBox =>
      Hive.box<BookingModel>(AppConstants.bookingsBox);

  static Future<void> saveBooking(BookingModel booking) async {
    await bookingsBox.put(booking.id, booking);
  }

  static Future<void> saveBookings(List<BookingModel> bookings) async {
    await bookingsBox.clear();
    for (var booking in bookings) {
      await bookingsBox.put(booking.id, booking);
    }
  }

  static List<BookingModel> getBookings() {
    return bookingsBox.values.toList();
  }

  static BookingModel? getBooking(String id) {
    return bookingsBox.get(id);
  }

  static Future<void> deleteBooking(String id) async {
    await bookingsBox.delete(id);
  }

  // Notification Operations
  static Box<NotificationModel> get notificationsBox =>
      Hive.box<NotificationModel>(AppConstants.notificationsBox);

  static Future<void> saveNotification(NotificationModel notification) async {
    await notificationsBox.put(notification.id, notification);
  }

  static List<NotificationModel> getNotifications() {
    return notificationsBox.values.toList();
  }

  static int getUnreadNotificationsCount() {
    return notificationsBox.values.where((n) => !n.isRead).length;
  }

  // Stylist Operations
  static Box<StylistModel> get stylistsBox =>
      Hive.box<StylistModel>(AppConstants.stylistsBox);

  static Future<void> saveStylists(List<StylistModel> stylists) async {
    await stylistsBox.clear();
    for (var stylist in stylists) {
      await stylistsBox.put(stylist.id, stylist);
    }
  }

  static List<StylistModel> getStylists() {
    return stylistsBox.values.toList();
  }

  // Theme Operations
  static Future<void> saveTheme(String theme) async {
    await settingsBox.put(AppConstants.themeKey, theme);
  }

  static String? getTheme() {
    return settingsBox.get(AppConstants.themeKey) as String?;
  }

  // Last Sync Operations
  static Future<void> saveLastSync(DateTime dateTime) async {
    await settingsBox.put(AppConstants.lastSyncKey, dateTime.toIso8601String());
  }

  static DateTime? getLastSync() {
    final syncStr = settingsBox.get(AppConstants.lastSyncKey) as String?;
    return syncStr != null ? DateTime.parse(syncStr) : null;
  }

  // Clear all data
  static Future<void> clearAllData() async {
    await userBox.clear();
    await servicesBox.clear();
    await bookingsBox.clear();
    await notificationsBox.clear();
    await stylistsBox.clear();
    await settingsBox.clear();
  }
}
