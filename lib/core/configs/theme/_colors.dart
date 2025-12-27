part of '../configs.dart';

abstract class AppColors {
  static const primary = Color(0xFFC58C24);
  static const tertiary = Color(0xFFE5B152);

  //
  static const textSub = Color.fromARGB(255, 90, 88, 88);
  static const textDark = Color(0xFF0B1120);

  static const background = Color(0xffF9F4ED);

  //
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

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
