import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/service_controller.dart';
import '../../controllers/booking_controller.dart';
import '../../models/service_model.dart';
import '../../utils/date_formatter.dart';
import '../../utils/validators.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final serviceController = Get.find<ServiceController>();
  final bookingController = Get.find<BookingController>();

  final _notesController = TextEditingController();

  ServicePackage? _selectedPackage;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final firstDate = now;
    final lastDate = now.add(
      Duration(days: AppConstants.maxBookingDaysInAdvance),
    );

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _handleBooking() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        Get.snackbar('Error', 'Please select a date');
        return;
      }

      if (_selectedTime == null) {
        Get.snackbar('Error', 'Please select a time');
        return;
      }

      final service = serviceController.selectedService.value;
      if (service == null) return;

      final dateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final success = await bookingController.createBooking(
        serviceId: service.id,
        packageId: _selectedPackage?.id,
        dateTime: dateTime,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          'Your booking has been created!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Booking')),
      body: Obx(() {
        final service = serviceController.selectedService.value;

        if (service == null) {
          return const Center(child: Text('No service selected'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Service Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${service.durationMinutes} min',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.attach_money,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            Text(
                              'PKR ${service.basePrice.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Package Selection
                if (service.packages.isNotEmpty) ...[
                  Text(
                    'Select Package',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...service.packages.map((package) {
                    return RadioListTile<ServicePackage>(
                      value: package,
                      groupValue: _selectedPackage,
                      onChanged: (value) {
                        setState(() {
                          _selectedPackage = value;
                        });
                      },
                      title: Text(package.name),
                      subtitle: Text(
                        'PKR ${package.price.toStringAsFixed(0)} • ${package.durationMinutes} min',
                      ),
                      dense: true,
                      tileColor: _selectedPackage == package
                          ? AppColors.primary.withOpacity(0.05)
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                ],

                // Date Selection
                Text(
                  'Select Date',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _selectedDate != null
                              ? DateFormatter.formatDate(_selectedDate!)
                              : 'Select Date',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Time Selection
                Text(
                  'Select Time',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: _selectTime,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Text(
                          _selectedTime != null
                              ? _selectedTime!.format(context)
                              : 'Select Time',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Notes
                Text(
                  'Additional Notes (Optional)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    hintText: 'Add any special requests or notes',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: Validators.validateNotes,
                ),

                const SizedBox(height: 32),

                // Submit Button
                Obx(
                  () => ElevatedButton(
                    onPressed: bookingController.isLoading.value
                        ? null
                        : _handleBooking,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: bookingController.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Confirm Booking',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
