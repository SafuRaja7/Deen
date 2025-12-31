import 'package:deen/core/router/routes.dart';
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
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  static String getIconForPrayer(String name) {
    switch (name.toLowerCase()) {
      case 'fajr':
        return StaticAssets.partialyCloudyNight;
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
    {
      'title': 'Qibla',
      'image': StaticAssets.qibla,
      "onTap": AppRoutes.qiblaDirectionScreen,
    },
    {'title': 'Quran', 'image': StaticAssets.logo, "onTap": AppRoutes.quran},
    {'title': 'Dua', 'image': StaticAssets.dua, "onTap": AppRoutes.onboarding},
    {
      'title': 'Prayer',
      'image': StaticAssets.prayer,
      "onTap": AppRoutes.onboarding,
    },
  ];

  static final List<Map<String, IconData>> suarhDetailsFeature = [
    {'icon': Icons.play_arrow},
    {'icon': Icons.star},
    {'icon': Icons.bookmark},
  ];

  static final List<String> quranScreenListItems = [
    "Surah",
    "Parah",
    "Bookmarks",
    "Juzz",
    "Hadith",
    "Hizb",
  ];

  static final List<Map<String, dynamic>> paraNames = [
    {
      "number": 1,
      "englishText": "Alif Lam Meem",
      "arabicText": "الم",
      "englishTranslation": "Alif, Lam, Meem",
    },
    {
      "number": 2,
      "englishText": "Sayaqool",
      "arabicText": "سيقول",
      "englishTranslation": "He will say",
    },
    {
      "number": 3,
      "englishText": "Tilka-r-Rusul",
      "arabicText": "تلك الرسل",
      "englishTranslation": "Those are the Messengers",
    },
    {
      "number": 4,
      "englishText": "Lan Tanaalu",
      "arabicText": "لن تنالوا",
      "englishTranslation": "You will never attain",
    },
    {
      "number": 5,
      "englishText": "Wal Mohsanat",
      "arabicText": "والمحصنات",
      "englishTranslation": "And the chaste women",
    },
    {
      "number": 6,
      "englishText": "La Yuhibbullah",
      "arabicText": "لا يحب الله",
      "englishTranslation": "Allah does not like",
    },
    {
      "number": 7,
      "englishText": "Wa Iza Samiu",
      "arabicText": "وإذا سمعوا",
      "englishTranslation": "And when they hear",
    },
    {
      "number": 8,
      "englishText": "Wa Lau Annana",
      "arabicText": "ولو أننا",
      "englishTranslation": "And if We had",
    },
    {
      "number": 9,
      "englishText": "Qalal Malao",
      "arabicText": "قال الملأ",
      "englishTranslation": "The chiefs said",
    },
    {
      "number": 10,
      "englishText": "Wa A'lamu",
      "arabicText": "واعلموا",
      "englishTranslation": "And know",
    },
    {
      "number": 11,
      "englishText": "Ya Tazeeroon",
      "arabicText": "يعتذرون",
      "englishTranslation": "They make excuses",
    },
    {
      "number": 12,
      "englishText": "Wa Mamin Daabbah",
      "arabicText": "وما من دابة",
      "englishTranslation": "And there is no creature",
    },
    {
      "number": 13,
      "englishText": "Wa Ma Ubarriu",
      "arabicText": "وما أبرئ",
      "englishTranslation": "And I do not acquit",
    },
    {
      "number": 14,
      "englishText": "Rubama",
      "arabicText": "ربما",
      "englishTranslation": "Perhaps",
    },
    {
      "number": 15,
      "englishText": "Subhanallazi",
      "arabicText": "سبحان الذي",
      "englishTranslation": "Glory be to Him who",
    },
    {
      "number": 16,
      "englishText": "Qal Alam",
      "arabicText": "قال ألم",
      "englishTranslation": "He said: Did I not",
    },
    {
      "number": 17,
      "englishText": "Iqtaraba",
      "arabicText": "اقترب",
      "englishTranslation": "The time has come near",
    },
    {
      "number": 18,
      "englishText": "Qad Aflaha",
      "arabicText": "قد أفلح",
      "englishTranslation": "Successful indeed",
    },
    {
      "number": 19,
      "englishText": "Wa Qalallazina",
      "arabicText": "وقال الذين",
      "englishTranslation": "And those who said",
    },
    {
      "number": 20,
      "englishText": "Aman Khalaq",
      "arabicText": "أمن خلق",
      "englishTranslation": "Is He who created",
    },
    {
      "number": 21,
      "englishText": "Utlu Ma Oohi",
      "arabicText": "اتل ما أوحي",
      "englishTranslation": "Recite what has been revealed",
    },
    {
      "number": 22,
      "englishText": "Wa Man Yaqnut",
      "arabicText": "ومن يقنت",
      "englishTranslation": "And whoever is devout",
    },
    {
      "number": 23,
      "englishText": "Wa Mali",
      "arabicText": "وما لي",
      "englishTranslation": "And what is wrong with me",
    },
    {
      "number": 24,
      "englishText": "Faman Azlam",
      "arabicText": "فمن أظلم",
      "englishTranslation": "Who is more unjust",
    },
    {
      "number": 25,
      "englishText": "Ilaihi Yuraddu",
      "arabicText": "إليه يرد",
      "englishTranslation": "To Him will be returned",
    },
    {
      "number": 26,
      "englishText": "Ha Meem",
      "arabicText": "حم",
      "englishTranslation": "Ha Meem",
    },
    {
      "number": 27,
      "englishText": "Qala Fama Khatbukum",
      "arabicText": "قال فما خطبكم",
      "englishTranslation": "He said: What is your matter?",
    },
    {
      "number": 28,
      "englishText": "Qad Sami Allah",
      "arabicText": "قد سمع الله",
      "englishTranslation": "Allah has heard",
    },
    {
      "number": 29,
      "englishText": "Tabarakallazi",
      "arabicText": "تبارك الذي",
      "englishTranslation": "Blessed is He",
    },
    {
      "number": 30,
      "englishText": "Amma",
      "arabicText": "عم",
      "englishTranslation": "About what?",
    },
  ];
}
