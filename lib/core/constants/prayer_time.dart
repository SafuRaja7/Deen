import 'package:deen/core/utils/statis_assets.dart';
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

  String get img {
    switch (this) {
      case PrayerTime.fajar:
        return StaticAssets.partialyCloudyNight;
      case PrayerTime.zuhr:
        return StaticAssets.sunny;
      case PrayerTime.asar:
        return StaticAssets.sunny;
      case PrayerTime.maghrib:
        return StaticAssets.maghribSun;
      case PrayerTime.isha:
        return StaticAssets.ishaNightMoon;
    }
  }

  static PrayerTime fromString(String name) {
    switch (name.toLowerCase()) {
      case 'fajr':
      case 'fajar':
        return PrayerTime.fajar;
      case 'dhuhr':
      case 'zuhr':
        return PrayerTime.zuhr;
      case 'asr':
      case 'asar':
        return PrayerTime.asar;
      case 'maghrib':
        return PrayerTime.maghrib;
      case 'isha':
        return PrayerTime.isha;
      default:
        return PrayerTime.fajar;
    }
  }
}
