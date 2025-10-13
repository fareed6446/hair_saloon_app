import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../services/hive_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _bookingReminders = true;
  bool _promotionalNotifications = true;
  String _language = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final settings = HiveService.settingsBox;
    setState(() {
      _notificationsEnabled = settings.get(
        'notifications_enabled',
        defaultValue: true,
      );
      _bookingReminders = settings.get('booking_reminders', defaultValue: true);
      _promotionalNotifications = settings.get(
        'promotional_notifications',
        defaultValue: true,
      );
      _language = settings.get('language', defaultValue: 'English');
    });
  }

  Future<void> _saveSettings() async {
    await HiveService.settingsBox.put(
      'notifications_enabled',
      _notificationsEnabled,
    );
    await HiveService.settingsBox.put('booking_reminders', _bookingReminders);
    await HiveService.settingsBox.put(
      'promotional_notifications',
      _promotionalNotifications,
    );
    await HiveService.settingsBox.put('language', _language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Notifications Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SwitchListTile(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                      if (!value) {
                        _bookingReminders = false;
                        _promotionalNotifications = false;
                      }
                    });
                    _saveSettings();
                  },
                  title: const Text('Enable Notifications'),
                  subtitle: const Text('Receive app notifications'),
                  secondary: const Icon(Icons.notifications),
                  activeColor: AppColors.primary,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _bookingReminders,
                  onChanged: _notificationsEnabled
                      ? (value) {
                          setState(() {
                            _bookingReminders = value;
                          });
                          _saveSettings();
                        }
                      : null,
                  title: const Text('Booking Reminders'),
                  subtitle: const Text('Get reminded before appointments'),
                  secondary: const Icon(Icons.alarm),
                  activeColor: AppColors.primary,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _promotionalNotifications,
                  onChanged: _notificationsEnabled
                      ? (value) {
                          setState(() {
                            _promotionalNotifications = value;
                          });
                          _saveSettings();
                        }
                      : null,
                  title: const Text('Promotional Offers'),
                  subtitle: const Text('Receive special offers and deals'),
                  secondary: const Icon(Icons.local_offer),
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Appearance Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Appearance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  subtitle: Text(_language),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showLanguageDialog();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.palette),
                  title: const Text('Theme'),
                  subtitle: const Text('Light'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Get.snackbar(
                      'Theme',
                      'Theme selection coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // App Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'App',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('Clear Cache'),
                  subtitle: const Text('Remove cached data'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showClearCacheDialog();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('App Version'),
                  subtitle: const Text('1.0.0'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              value: 'English',
              groupValue: _language,
              onChanged: (value) {
                setState(() {
                  _language = value!;
                });
                _saveSettings();
                Get.back();
              },
              title: const Text('English'),
            ),
            RadioListTile<String>(
              value: 'Urdu',
              groupValue: _language,
              onChanged: (value) {
                setState(() {
                  _language = value!;
                });
                _saveSettings();
                Get.back();
              },
              title: const Text('اردو'),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCacheDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will remove all cached data including services and images. Are you sure?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              // Clear only services cache, not user data
              await HiveService.servicesBox.clear();
              Get.snackbar(
                'Success',
                'Cache cleared successfully',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
