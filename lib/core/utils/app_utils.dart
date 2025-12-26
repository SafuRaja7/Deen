import 'package:deen/core/utils/static_assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static String convertTo12Hour(String time24) {
    if (time24 == '--:--') return time24;
    try {
      final dateTime = DateFormat("HH:mm").parse(time24);
      return DateFormat("hh:mm a").format(dateTime);
    } catch (e) {
      return time24;
    }
  }

  static String getFormattedDate() {
    return DateFormat("d MMMM yyyy").format(DateTime.now());
  }

  static final List<String> prayerNames = [
    'Fajr',
    'Sunrise',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  static String getIconForPrayer(String name) {
    switch (name.toLowerCase()) {
      case 'fajr':
        return StaticAssets.partialyCloudyNight;
      case 'sunrise':
        return StaticAssets.maghribSun;
      case 'dhuhr':
        return StaticAssets.sunny;
      case 'asr':
        return StaticAssets.sunny;
      case 'maghrib':
        return StaticAssets.maghribSun;
      case 'isha':
        return StaticAssets.ishaNightMoon;
      default:
        return StaticAssets.sunny;
    }
  }

  static const List<String> verseReferences = [
    '2:153',
    '2:155',
    '2:156',
    '3:200',
    '16:127',
    '8:46',
    '11:115',
    '30:60',
    '31:17',
    '39:10',
    '25:75',
    '47:31',
    '70:5',
    '2:282',
    '28:59',
    '21:73',
    '11:118',
    '16:42',
    '17:7',
    '42:43',
    '22:35',
    '28:54',
    '28:80',
    '24:55',
    '9:87',
    '103:3',
    '13:24',
    '32:24',
  ];

  static final List<Map<String, dynamic>> list = [
    {
      "image": StaticAssets.faith1,
      "title": "Understanding the Five Pillars of Islam",
      "desc":
          "Dive into the foundational principles of Islam, from the declaration of faith to prayer, almsgiving, fasting, and pilgrimage, and their role in a Muslim's life.",
    },
    {
      "image": StaticAssets.faith2,
      "title": "Exploring the Quran: The Holy Book\nof Islam",
      "desc":
          "Uncover the profound teachings of the Quran, its historical context, and its impact on the lives of Muslims around the world.",
    },
  ];

  static final List<Map<String, String>> homeFeaturesRow = [
    {'title': 'Qibla', 'image': StaticAssets.qibla},
    {'title': 'Quran', 'image': StaticAssets.logo},
    {'title': 'Dua', 'image': StaticAssets.dua},
    {'title': 'Prayer', 'image': StaticAssets.prayer},
  ];
}
