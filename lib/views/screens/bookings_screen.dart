import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/booking_controller.dart';
import '../widgets/booking_card.dart';
import '../../constants/app_colors.dart';
import '../../routes/app_routes.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final bookingController = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: Obx(() {
        if (bookingController.isLoading.value &&
            bookingController.bookings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return TabBarView(
          controller: _tabController,
          children: [
            // Upcoming Bookings
            _buildBookingsList(bookingController.upcomingBookings, 'upcoming'),
            // Past Bookings
            _buildBookingsList(bookingController.pastBookings, 'past'),
            // Cancelled Bookings
            _buildBookingsList(
              bookingController.cancelledBookings,
              'cancelled',
            ),
          ],
        );
      }),
    );
  }

  Widget _buildBookingsList(List bookings, String type) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 'upcoming'
                  ? Icons.calendar_today
                  : type == 'past'
                  ? Icons.history
                  : Icons.cancel,
              size: 64,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No ${type} bookings',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => bookingController.fetchUserBookings(refresh: true),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookingCard(
              booking: booking,
              onTap: () {
                bookingController.selectBooking(booking);
                Get.toNamed(AppRoutes.bookingDetail);
              },
              onCancel: type == 'upcoming'
                  ? () => _showCancelDialog(booking.id)
                  : null,
            ),
          );
        },
      ),
    );
  }

  void _showCancelDialog(String bookingId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('No')),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await bookingController.cancelBooking(bookingId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}
