import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // App Logo/Icon
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.content_cut,
                size: 80,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),

            // App Name
            Text(
              'Hair Salon App',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Version 1.0.0',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),

            const SizedBox(height: 32),

            // About Description
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Us',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Welcome to our professional Hair Salon! We provide premium grooming services with a commitment to excellence. Our app makes it easy to book appointments, track your visit history, and earn rewards.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Features
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Features',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureItem(
                      context,
                      icon: Icons.check_circle,
                      text: 'Easy online booking system',
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.check_circle,
                      text: 'Professional stylists',
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.check_circle,
                      text: 'Loyalty rewards program',
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.check_circle,
                      text: 'Service packages & offers',
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.check_circle,
                      text: 'Booking history tracking',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Social Links
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connect With Us',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton(
                          icon: Icons.facebook,
                          label: 'Facebook',
                          onTap: () {},
                        ),
                        _buildSocialButton(
                          icon: Icons.camera_alt,
                          label: 'Instagram',
                          onTap: () {},
                        ),
                        _buildSocialButton(
                          icon: Icons.link,
                          label: 'Website',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Legal Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to privacy policy
                  },
                  child: const Text('Privacy Policy'),
                ),
                const Text('•'),
                TextButton(
                  onPressed: () {
                    // Navigate to terms of service
                  },
                  child: const Text('Terms of Service'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Copyright
            Text(
              '© 2025 Hair Salon App. All rights reserved.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.success, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
