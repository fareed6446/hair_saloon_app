import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        final user = authController.currentUser.value;

        if (user == null) {
          return const Center(child: Text('Not logged in'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
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
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.fullName,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.phone,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                    ),
                    if (user.email != null && user.email!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        user.email!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Loyalty Points Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: AppColors.accent.withOpacity(0.1),
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.loyaltyProgram),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.card_giftcard,
                              color: Colors.amber,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Loyalty Points',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.loyaltyPoints.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.textLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Menu Items
              _buildMenuItem(
                context,
                icon: Icons.edit,
                title: 'Edit Profile',
                onTap: () => Get.toNamed(AppRoutes.editProfile),
              ),
              _buildMenuItem(
                context,
                icon: Icons.calendar_today,
                title: 'My Bookings',
                onTap: () => Get.toNamed(AppRoutes.bookings),
              ),
              _buildMenuItem(
                context,
                icon: Icons.card_giftcard,
                title: 'Loyalty Program',
                onTap: () => Get.toNamed(AppRoutes.loyaltyProgram),
              ),
              _buildMenuItem(
                context,
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () => Get.toNamed(AppRoutes.notifications),
              ),
              _buildMenuItem(
                context,
                icon: Icons.settings,
                title: 'Settings',
                onTap: () => Get.toNamed(AppRoutes.settings),
              ),
              _buildMenuItem(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () => Get.toNamed(AppRoutes.helpSupport),
              ),
              _buildMenuItem(
                context,
                icon: Icons.info_outline,
                title: 'About',
                onTap: () => Get.toNamed(AppRoutes.about),
              ),

              const Divider(height: 32),

              // Logout Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showLogoutDialog(context),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.textLight,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final authController = Get.find<AuthController>();

    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              authController.logout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
