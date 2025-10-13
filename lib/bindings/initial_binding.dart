import 'package:get/get.dart';
import '../services/api_service.dart';
import '../controllers/auth_controller.dart';
import '../controllers/service_controller.dart';
import '../controllers/booking_controller.dart';
import '../controllers/notification_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register Services
    Get.put<ApiService>(ApiService(), permanent: true);

    // Register Controllers
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ServiceController>(ServiceController(), permanent: true);
    Get.put<BookingController>(BookingController(), permanent: true);
    Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
