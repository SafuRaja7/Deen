import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGold = Color(0xFFC58C24);
  static const Color secondaryDark = Color(0xFF0B1120);
  static const Color backgroundBeige = Color(0xFFF5F5F3);
  static const Color pureWhite = Color(0xFFFFFFFF);
  
  static const Color textDark = Color(0xFF0B1120);
  static const Color textGrey = Color(0xFF717171);
  static const Color textLight = Color(0xFFACACAC);

  static const Color cardBlue = Color(0xFF141D33);
  static const Color accentGold = Color(0xFFE5B152);

  // Gradient for the Home Card
  static const LinearGradient prayerCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF0F172A),
    ],
  );
}
