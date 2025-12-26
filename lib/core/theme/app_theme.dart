import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primaryGold,
      scaffoldBackgroundColor: AppColors.backgroundBeige,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGold,
        primary: AppColors.primaryGold,
        secondary: AppColors.secondaryDark,
      ),
      cardTheme: CardThemeData(
        color: AppColors.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
