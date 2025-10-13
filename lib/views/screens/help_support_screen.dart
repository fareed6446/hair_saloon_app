import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.help_outline, size: 60, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'How can we help you?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We\'re here to assist you',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Options
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    context,
                    icon: Icons.phone,
                    title: 'Phone',
                    subtitle: '+92 300 1234567',
                    onTap: () {
                      Get.snackbar(
                        'Call',
                        'Calling +92 300 1234567...',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    context,
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'support@hairsalon.com',
                    onTap: () {
                      Get.snackbar(
                        'Email',
                        'Opening email client...',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    context,
                    icon: Icons.location_on,
                    title: 'Visit Us',
                    subtitle: '123 Main Street, Karachi, Pakistan',
                    onTap: () {
                      Get.snackbar(
                        'Location',
                        'Opening maps...',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    context,
                    icon: Icons.access_time,
                    title: 'Working Hours',
                    subtitle: 'Mon-Sun: 9:00 AM - 8:00 PM',
                    onTap: null,
                  ),
                ],
              ),
            ),

            // FAQs Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFAQItem(
                    context,
                    question: 'How do I book an appointment?',
                    answer:
                        'Browse services, select your preferred service, choose date and time, and confirm your booking.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'Can I cancel my booking?',
                    answer:
                        'Yes, you can cancel your upcoming bookings from the My Bookings section.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'How do loyalty points work?',
                    answer:
                        'Earn 1 point for every PKR 100 spent. Redeem points for discounts on future bookings.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'What payment methods are accepted?',
                    answer:
                        'We accept cash, credit cards, and mobile payments at the salon after service completion.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'Can I choose my stylist?',
                    answer:
                        'Yes, you can select your preferred stylist when creating a booking.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: onTap != null
            ? const Icon(Icons.arrow_forward_ios, size: 16)
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        question,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            answer,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
