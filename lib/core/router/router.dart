import 'package:deen/core/router/routes.dart';
import 'package:deen/features/home/presentation/home_screen.dart';
import 'package:deen/features/onboarding/presentation/onboarding_screen.dart';
import 'package:deen/features/prayer_timings/presentation/prayer_timings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_bloc.dart';
import 'package:deen/features/hadith/presentation/hadith_screen.dart';
import 'package:deen/features/hadith/presentation/hadith_chapters_screen.dart';
import 'package:deen/features/hadith/presentation/hadith_list_screen.dart';

import 'package:deen/features/para_details_screen/presentation/para_details_screen_screen.dart';

import 'package:deen/features/surah_details/presentation/surah_details_screen.dart';

import 'package:deen/features/quran/presentation/quran_screen.dart';

final appRoutes = {
  AppRoutes.hadith: (_) => const HadithScreen(),

  AppRoutes.paraDetailsScreen: (_) => const ParaDetailsScreenScreen(),

  AppRoutes.surahDetails: (_) => const SurahDetailsScreen(),

  AppRoutes.quran: (_) => const QuranScreen(),

  AppRoutes.home: (_) => const HomeScreen(),
  AppRoutes.onboarding: (_) => const OnboardingScreen(),
  AppRoutes.prayerTimings: (_) => const PrayerTimingsScreen(),
};

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return FadeRoute(child: const HomeScreen(), settings: settings);
    case AppRoutes.onboarding:
      return FadeRoute(child: const OnboardingScreen(), settings: settings);
    case AppRoutes.prayerTimings:
      return FadeRoute(child: const PrayerTimingsScreen(), settings: settings);

    case AppRoutes.quran:
      return FadeRoute(child: const QuranScreen(), settings: settings);
    case AppRoutes.surahDetails:
      return FadeRoute(child: const SurahDetailsScreen(), settings: settings);
    case AppRoutes.paraDetailsScreen:
      return FadeRoute(
        child: const ParaDetailsScreenScreen(),
        settings: settings,
      );
    case AppRoutes.hadith:
      return FadeRoute(child: const HadithScreen(), settings: settings);
    case AppRoutes.hadithChapters:
      final args = settings.arguments as Map<String, dynamic>;
      return FadeRoute(
        child: BlocProvider(
          create: (context) => HadithBloc(),
          child: HadithChaptersScreen(
            bookSlug: args['bookSlug'],
            bookName: args['bookName'],
          ),
        ),
        settings: settings,
      );
    case AppRoutes.hadithList:
      final args = settings.arguments as Map<String, dynamic>;
      return FadeRoute(
        child: BlocProvider(
          create: (context) => HadithBloc(),
          child: HadithListScreen(
            bookSlug: args['bookSlug'],
            chapterNumber: args['chapterNumber'],
            chapterName: args['chapterName'],
          ),
        ),
        settings: settings,
      );

    default:
      return null;
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;

  @override
  final RouteSettings settings;

  FadeRoute({required this.child, required this.settings})
    : super(
        settings: settings,
        pageBuilder: (context, ani1, ani2) => child,
        transitionsBuilder: (context, ani1, ani2, child) {
          return FadeTransition(opacity: ani1, child: child);
        },
      );
}
