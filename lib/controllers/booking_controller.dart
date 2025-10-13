import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../models/time_slot_model.dart';
import '../services/api_service.dart';
import '../services/hive_service.dart';
import 'auth_controller.dart';
import 'package:intl/intl.dart';

class BookingController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final AuthController _authController = Get.find<AuthController>();

  final RxList<BookingModel> bookings = <BookingModel>[].obs;
  final RxList<TimeSlotModel> availableSlots = <TimeSlotModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingSlots = false.obs;
  final Rx<BookingModel?> selectedBooking = Rx<BookingModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadCachedBookings();
    if (_authController.userId != null) {
      fetchUserBookings();
    }
  }

  void _loadCachedBookings() {
    final cachedBookings = HiveService.getBookings();
    if (cachedBookings.isNotEmpty) {
      bookings.value = cachedBookings;
    }
  }

  Future<void> fetchUserBookings({bool refresh = false}) async {
    final userId = _authController.userId;
    if (userId == null) return;

    try {
      isLoading.value = true;

      final response = await _apiService.getUserBookings(userId);
      final fetchedBookings = response
          .map((json) => BookingModel.fromJson(json as Map<String, dynamic>))
          .toList();

      bookings.value = fetchedBookings;

      // Save to local storage
      await HiveService.saveBookings(fetchedBookings);

      if (refresh) {
        Get.snackbar(
          'Success',
          'Bookings refreshed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load bookings: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTimeSlots({
    required String serviceId,
    required DateTime date,
  }) async {
    try {
      isLoadingSlots.value = true;

      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final response = await _apiService.getTimeSlots(
        serviceId: serviceId,
        date: dateStr,
      );

      final slots = (response['slots'] as List<dynamic>)
          .map((json) => TimeSlotModel.fromJson(json as Map<String, dynamic>))
          .toList();

      availableSlots.value = slots;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load time slots: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingSlots.value = false;
    }
  }

  Future<bool> createBooking({
    required String serviceId,
    String? packageId,
    String? stylistId,
    required DateTime dateTime,
    String? notes,
  }) async {
    final userId = _authController.userId;
    if (userId == null) {
      Get.snackbar(
        'Error',
        'User not logged in',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    try {
      isLoading.value = true;

      final data = {
        'user_id': userId,
        'service_id': serviceId,
        'package_id': packageId,
        'stylist_id': stylistId,
        'date_time': dateTime.toUtc().toIso8601String(),
        'notes': notes,
      };

      final response = await _apiService.createBooking(data);
      final booking = BookingModel.fromJson(response);

      // Add to local list
      bookings.insert(0, booking);
      await HiveService.saveBooking(booking);

      Get.snackbar(
        'Success',
        'Booking created successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create booking: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    try {
      isLoading.value = true;

      await _apiService.cancelBooking(bookingId);

      // Update local booking
      final index = bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        bookings[index].status = 'cancelled';
        await HiveService.saveBooking(bookings[index]);
        bookings.refresh();
      }

      Get.snackbar(
        'Success',
        'Booking cancelled successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to cancel booking: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void selectBooking(BookingModel booking) {
    selectedBooking.value = booking;
  }

  void clearSelectedBooking() {
    selectedBooking.value = null;
  }

  List<BookingModel> get upcomingBookings {
    return bookings.where((booking) => booking.isUpcoming).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  List<BookingModel> get pastBookings {
    return bookings
        .where((booking) => booking.isPast || booking.isCompleted)
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  List<BookingModel> get cancelledBookings {
    return bookings.where((booking) => booking.isCancelled).toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }
}
