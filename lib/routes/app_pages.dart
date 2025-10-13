import 'package:get/get.dart';
import '../views/screens/splash_screen.dart';
import '../views/screens/onboarding_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/register_screen.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/service_detail_screen.dart';
import '../views/screens/create_booking_screen.dart';
import '../views/screens/booking_detail_screen.dart';
import '../views/screens/bookings_screen.dart';
import '../views/screens/profile_screen.dart';
import '../views/screens/edit_profile_screen.dart';
import '../views/screens/loyalty_program_screen.dart';
import '../views/screens/loyalty_history_screen.dart';
import '../views/screens/select_stylist_screen.dart';
import '../views/screens/notifications_screen.dart';
import '../views/screens/settings_screen.dart';
import '../views/screens/help_support_screen.dart';
import '../views/screens/about_screen.dart';
import '../bindings/initial_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: InitialBinding(),
    ),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(
      name: AppRoutes.serviceDetail,
      page: () => const ServiceDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.createBooking,
      page: () => const CreateBookingScreen(),
    ),
    GetPage(
      name: AppRoutes.bookingDetail,
      page: () => const BookingDetailScreen(),
    ),
    GetPage(name: AppRoutes.bookings, page: () => const BookingsScreen()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.editProfile, page: () => const EditProfileScreen()),
    GetPage(
      name: AppRoutes.loyaltyProgram,
      page: () => const LoyaltyProgramScreen(),
    ),
    GetPage(
      name: AppRoutes.loyaltyHistory,
      page: () => const LoyaltyHistoryScreen(),
    ),
    GetPage(
      name: AppRoutes.selectStylist,
      page: () => const SelectStylistScreen(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
    ),
    GetPage(name: AppRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: AppRoutes.helpSupport, page: () => const HelpSupportScreen()),
    GetPage(name: AppRoutes.about, page: () => const AboutScreen()),
  ];
}
