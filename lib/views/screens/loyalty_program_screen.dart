import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class LoyaltyProgramScreen extends StatelessWidget {
  const LoyaltyProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Loyalty Program')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Points Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.card_giftcard,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your Loyalty Points',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      authController.loyaltyPoints.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Keep booking to earn more!',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // View History Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.loyaltyHistory),
                icon: const Icon(Icons.history),
                label: const Text('View Transaction History'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // How It Works Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How It Works',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildHowItWorksItem(
                    context,
                    icon: Icons.money,
                    title: 'Earn Points',
                    description:
                        'Earn ${AppConstants.loyaltyPointsPerHundred} point for every PKR 100 spent on completed bookings.',
                  ),
                  const SizedBox(height: 12),
                  _buildHowItWorksItem(
                    context,
                    icon: Icons.redeem,
                    title: 'Redeem Rewards',
                    description:
                        'Redeem your points for discounts on your next visit. Minimum ${AppConstants.minPointsForRedemption} points required.',
                  ),
                  const SizedBox(height: 12),
                  _buildHowItWorksItem(
                    context,
                    icon: Icons.cake,
                    title: 'First Booking Bonus',
                    description:
                        'Get ${AppConstants.firstBookingBonusPercent}% discount on your first completed booking!',
                  ),
                  const SizedBox(height: 12),
                  _buildHowItWorksItem(
                    context,
                    icon: Icons.timer,
                    title: 'Points Expiry',
                    description:
                        'Points expire after ${AppConstants.pointsExpiryDays} days from the date earned.',
                  ),
                ],
              ),
            ),

            // Rewards Tiers
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rewards Tiers',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRewardTier(
                    context,
                    points: '50',
                    reward: '5% Discount',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildRewardTier(
                    context,
                    points: '100',
                    reward: '10% Discount',
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 12),
                  _buildRewardTier(
                    context,
                    points: '200',
                    reward: '15% Discount + Free Service',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
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

  Widget _buildRewardTier(
    BuildContext context, {
    required String points,
    required String reward,
    required Color color,
  }) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 4)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  points,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Points',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            const Icon(Icons.arrow_forward, color: AppColors.textLight),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                reward,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
