import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      // scaffoldBackgroundColor: Colors.white,
      fontFamily: 'SegoeUI',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.app_color,
        foregroundColor: AppColors.white,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
