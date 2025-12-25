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
  static const Color overlayGrey = Color(0xFFF4F4F4);

  // Prayer Gradients
  static const LinearGradient fajarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEFC977), Color(0xFFE07256)],
  );

  static const LinearGradient zuhrGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF006A81), Color(0xFF006A81)],
  );

  static const LinearGradient asarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFBC2B), Color(0xFFE07256)],
  );

  static const LinearGradient maghribGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFCB7D00), Color(0xFF6F4400)],
  );

  static const LinearGradient ishaGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF060081), Color(0xFF060081)],
  );

  // Gradient for the Home Card
  static const LinearGradient prayerCardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
  );
}
