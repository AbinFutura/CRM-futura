import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/theme/app_colors.dart';

class AppTextTheme {

  static TextTheme textTheme = const TextTheme(

    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
    ),

    bodySmall: TextStyle(
      fontSize: 12,
      color: AppColors.fadedGrey,
    ),

  );

  static const TextStyle dialogTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle dialogBody = TextStyle(
    fontSize: 15,
  );
}