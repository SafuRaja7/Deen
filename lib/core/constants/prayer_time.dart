import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum PrayerTime {
  fajar,
  zuhr,
  asar,
  maghrib,
  isha;

  LinearGradient get gradient {
    switch (this) {
      case PrayerTime.fajar:
        return AppColors.fajarGradient;
      case PrayerTime.zuhr:
        return AppColors.zuhrGradient;
      case PrayerTime.asar:
        return AppColors.asarGradient;
      case PrayerTime.maghrib:
        return AppColors.maghribGradient;
      case PrayerTime.isha:
        return AppColors.ishaGradient;
    }
  }

  String get displayName {
    switch (this) {
      case PrayerTime.fajar:
        return 'Fajar';
      case PrayerTime.zuhr:
        return 'Zuhr';
      case PrayerTime.asar:
        return 'Asar';
      case PrayerTime.maghrib:
        return 'Maghrib';
      case PrayerTime.isha:
        return 'Isha';
    }
  }
}
