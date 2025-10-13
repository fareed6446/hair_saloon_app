class AppConstants {
  // API Configuration
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api',
  );

  // Hive Box Names
  static const String userBox = 'user_box';
  static const String servicesBox = 'services_box';
  static const String bookingsBox = 'bookings_box';
  static const String notificationsBox = 'notifications_box';
  static const String stylistsBox = 'stylists_box';
  static const String settingsBox = 'settings_box';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String currentUserKey = 'current_user';
  static const String themeKey = 'app_theme';
  static const String lastSyncKey = 'last_sync';

  // API Endpoints
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String meEndpoint = '/auth/me';
  static const String servicesEndpoint = '/services';
  static const String bookingsEndpoint = '/bookings';
  static const String timeSlotsEndpoint = '/time-slots';
  static const String notificationsEndpoint = '/notifications';

  // Business Rules
  static const int loyaltyPointsPerHundred = 1;
  static const int minPointsForRedemption = 50;
  static const int firstBookingBonusPercent = 10;
  static const int pointsExpiryDays = 365;

  // UI Configuration
  static const int maxBookingDaysInAdvance = 60;
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int itemsPerPage = 20;

  // Validation
  static const String phoneRegex = r'^\+92[0-9]{10}$';
  static const int minPasswordLength = 6;
  static const int maxNameLength = 100;
  static const int maxNotesLength = 500;
}
