import '../constants/app_constants.dart';

class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(AppConstants.phoneRegex);
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number format (e.g., +923001234567)';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Email is optional
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length > AppConstants.maxNameLength) {
      return 'Name is too long';
    }

    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateNotes(String? value) {
    if (value != null && value.length > AppConstants.maxNotesLength) {
      return 'Notes are too long (max ${AppConstants.maxNotesLength} characters)';
    }
    return null;
  }

  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    String digitsOnly = phone.replaceAll(RegExp(r'\D'), '');

    // If starts with 92, add +
    if (digitsOnly.startsWith('92')) {
      return '+$digitsOnly';
    }

    // If starts with 0, replace with +92
    if (digitsOnly.startsWith('0')) {
      return '+92${digitsOnly.substring(1)}';
    }

    // Otherwise, assume it's just the number without country code
    if (digitsOnly.length == 10) {
      return '+92$digitsOnly';
    }

    return phone;
  }
}
