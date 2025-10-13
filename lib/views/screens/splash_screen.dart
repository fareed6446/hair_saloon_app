import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    final authController = Get.find<AuthController>();

    // Check if onboarding has been completed
    final onboardingCompleted =
        authController.isAuthenticated.value ||
        (Get.find<AuthController>().currentUser.value != null);

    // Check from Hive storage
    final box = await Hive.openBox('settings_box');
    final hasSeenOnboarding = box.get(
      'onboarding_completed',
      defaultValue: false,
    );

    if (!hasSeenOnboarding) {
      Get.offNamed(AppRoutes.onboarding);
    } else if (authController.isAuthenticated.value) {
      Get.offNamed(AppRoutes.home);
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.content_cut, size: 100, color: Colors.white),
              const SizedBox(height: 24),
              Text(
                'Hair Salon',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Book your perfect style',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
