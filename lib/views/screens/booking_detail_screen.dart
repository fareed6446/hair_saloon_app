import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/booking_controller.dart';
import '../../utils/date_formatter.dart';
import '../../constants/app_colors.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingController = Get.find<BookingController>();

    return Obx(() {
      final booking = bookingController.selectedBooking.value;

      if (booking == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Booking Details')),
          body: const Center(child: Text('Booking not found')),
        );
      }

      return Scaffold(
        appBar: AppBar(title: const Text('Booking Details')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status Badge
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    booking.status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(booking.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Service Info
              _buildInfoCard(
                context,
                icon: Icons.content_cut,
                title: 'Service',
                value: booking.service?.title ?? 'N/A',
              ),

              const SizedBox(height: 12),

              // Date & Time
              _buildInfoCard(
                context,
                icon: Icons.calendar_today,
                title: 'Date & Time',
                value: DateFormatter.formatDateTime(booking.dateTime),
              ),

              if (booking.package != null) ...[
                const SizedBox(height: 12),
                _buildInfoCard(
                  context,
                  icon: Icons.local_offer,
                  title: 'Package',
                  value:
                      '${booking.package!.name} - PKR ${booking.package!.price.toStringAsFixed(0)}',
                ),
              ],

              if (booking.stylist != null) ...[
                const SizedBox(height: 12),
                _buildInfoCard(
                  context,
                  icon: Icons.person,
                  title: 'Stylist',
                  value: booking.stylist!.name,
                ),
              ],

              const SizedBox(height: 12),
              _buildInfoCard(
                context,
                icon: Icons.access_time,
                title: 'Duration',
                value:
                    '${booking.service?.durationMinutes ?? booking.package?.durationMinutes ?? 0} minutes',
              ),

              if (booking.notes != null && booking.notes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildInfoCard(
                  context,
                  icon: Icons.note,
                  title: 'Notes',
                  value: booking.notes!,
                ),
              ],

              if (booking.loyaltyPointsAwarded > 0) ...[
                const SizedBox(height: 12),
                _buildInfoCard(
                  context,
                  icon: Icons.card_giftcard,
                  title: 'Loyalty Points Awarded',
                  value: booking.loyaltyPointsAwarded.toString(),
                ),
              ],

              const SizedBox(height: 12),
              _buildInfoCard(
                context,
                icon: Icons.history,
                title: 'Booked On',
                value: DateFormatter.formatDateTime(booking.createdAt),
              ),

              const SizedBox(height: 24),

              // Actions
              if (booking.status == 'booked' && booking.isUpcoming) ...[
                ElevatedButton.icon(
                  onPressed: () => _showCancelDialog(context, booking.id),
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel Booking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'booked':
        return AppColors.statusBooked;
      case 'completed':
        return AppColors.statusCompleted;
      case 'cancelled':
        return AppColors.statusCancelled;
      case 'no_show':
        return AppColors.statusNoShow;
      default:
        return AppColors.textSecondary;
    }
  }

  void _showCancelDialog(BuildContext context, String bookingId) {
    final bookingController = Get.find<BookingController>();

    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('No')),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              final success = await bookingController.cancelBooking(bookingId);
              if (success) {
                Get.back(); // Go back to bookings list
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}
