import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2C3E50);
  static const Color primaryDark = Color(0xFF1A252F);
  static const Color primaryLight = Color(0xFF34495E);

  // Accent Colors
  static const Color accent = Color(0xFF3498DB);
  static const Color accentDark = Color(0xFF2980B9);
  static const Color accentLight = Color(0xFF5DADE2);

  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Colors.white;
  static const Color darkBackground = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFF95A5A6);
  static const Color textDark = Colors.white;

  // Status Colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // Booking Status Colors
  static const Color statusBooked = Color(0xFF3498DB);
  static const Color statusCompleted = Color(0xFF27AE60);
  static const Color statusCancelled = Color(0xFFE74C3C);
  static const Color statusNoShow = Color(0xFF95A5A6);

  // UI Element Colors
  static const Color border = Color(0xFFECF0F1);
  static const Color divider = Color(0xFFBDC3C7);
  static const Color shadow = Color(0x1A000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
