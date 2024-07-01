import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      // scaffoldBackgroundColor: Colors.white,
      fontFamily: 'SegoeUI',
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.appColor,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors.white,
          systemNavigationBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
    );
  }
}
