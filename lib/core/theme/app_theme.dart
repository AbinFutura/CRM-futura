import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: Colors.white,

    textTheme: AppTextTheme.textTheme,

    /// APP BAR THEME
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),

    /// Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: AppColors.primary,

        foregroundColor: AppColors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),

      ),

    ),

    /// Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(

      style: OutlinedButton.styleFrom(

        foregroundColor: AppColors.primary,

        side: const BorderSide(
          color: AppColors.primary,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),

      ),

    ),

    /// Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(

      backgroundColor: AppColors.primary,

      foregroundColor: Colors.white,

    ),

    /// Input Decoration Theme (for all TextFields)
    inputDecorationTheme: InputDecorationTheme(

      filled: true,
      fillColor: AppColors.fadedPrimary,

      hintStyle: const TextStyle(
        color: AppColors.fadedGrey,
        fontSize: 12,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),

    ),

  );

}