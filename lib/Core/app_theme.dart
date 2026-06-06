import 'package:flutter/material.dart';

class AppColors {
  // Primary palette
  static const primary = Color(0xFF5E39E0);
  static const primaryContainer = Color(0xFF7757FA);
  static const secondary = Color(0xFF674BB5);
  static const secondaryContainer = Color(0xFFAB8FFE);

  // Surface
  static const surface = Color(0xFFFDF8FF);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF7F1FF);
  static const surfaceContainer = Color(0xFFF1EBF9);
  static const surfaceContainerHigh = Color(0xFFEBE6F4);
  static const surfaceContainerHighest = Color(0xFFE6E0EE);

  // On colors
  static const onSurface = Color(0xFF1C1A24);
  static const onSurfaceVariant = Color(0xFF484555);
  static const outline = Color(0xFF797587);
  static const outlineVariant = Color(0xFFC9C4D8);

  // Background
  static const background = Color(0xFFFDF8FF);

  // Accent
  static const pink = Color(0xFFFF4F8B);
  static const cyan = Color(0xFF00D4FF);

  // Gradients
  static const splashGradient = [
    Color(0xFF7B5FE0),
    Color(0xFF9B6FD0),
    Color(0xFFE0906E),
    Color(0xFFF0B060),
  ];

  static const onboardingGradient = [
    Color(0xFF4A2FA0),
    Color(0xFF7B5FE0),
    Color(0xFFD06090),
    Color(0xFFFF9060),
  ];

  static const primaryGradient = [
    Color(0xFF5E39E0),
    Color(0xFF7B5FE0),
  ];
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans',
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
        ),
        scaffoldBackgroundColor: AppColors.background,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.outlineVariant,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.outlineVariant,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      );
}
