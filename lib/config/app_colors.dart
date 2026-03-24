import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  // Primary colors
  static const Color primary = Color(0xFF007AFF); // iOS Blue
  static const Color secondary = Color(0xFF5856D6); // iOS Purple
  static const Color background = Color(0xFFF2F2F7); // iOS Light Background
  static const Color surface = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF0A84FF); // iOS Dark Blue
  static const Color secondaryDark = Color(0xFF5E5CE6); // iOS Dark Purple
  static const Color backgroundDark = Color(0xFF000000); // iOS Dark Background
  static const Color surfaceDark = Color(0xFF1C1C1E); // iOS Dark Surface
  static const Color surfaceDark2 = Color(0xFF2C2C2E); // iOS Dark Surface 2

  // Dice board colors
  static const Color diceBoard = Color(0xFF1C1C1E);
  static const Color diceBoardLight = Color(0xFF2C2C2E);

  // Player colors (for turn indication like Ludo)
  static const List<Color> playerColors = [
    Color(0xFFFF3B30), // Red
    Color(0xFF34C759), // Green
    Color(0xFFFFCC00), // Yellow
    Color(0xFF007AFF), // Blue
  ];

  // Dice colors
  static const Color diceWhite = Color(0xFFFFFFFF);
  static const Color diceDot = Color(0xFF000000);
  static const Color diceShadow = Color(0x40000000);

  // Text colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // Dark theme text colors
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF98989D);

  // Status colors
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFFCC00);

  // Navigation colors
  static const Color navBarBackground = Color(0xFFF9F9F9);
  static const Color navBarIcon = Color(0xFF8E8E93);
  static const Color navBarIconActive = Color(0xFF007AFF);

  // Dark theme navigation
  static const Color navBarBackgroundDark = Color(0xFF1C1C1E);
  static const Color navBarIconDark = Color(0xFF98989D);
  static const Color navBarIconActiveDark = Color(0xFF0A84FF);

  // Settings toggle
  static const Color toggleActive = Color(0xFF34C759);
  static const Color toggleInactive = Color(0xFFE5E5EA);
}
